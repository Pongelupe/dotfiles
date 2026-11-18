#!/bin/bash

git_status_all() {
    for dir in */; do
        if [ -d "$dir/.git" ]; then
            echo "=== $dir ==="
            cd "$dir"
            git status --porcelain
            cd ..
            echo
        fi
    done
}

git_time_machine() {
    local COMPRESS=false
    local OPTIND opt
    while getopts "c" opt; do
        case $opt in c) COMPRESS=true ;; *) return 1 ;; esac
    done
    shift $((OPTIND - 1))

    local REF="${1:-origin/main}"
    local OUTDIR="${2:-time-machine}"

    git fetch --quiet 2>/dev/null || true

    local COUNT=$(git rev-list --count "$REF"..HEAD)
    if [ "$COUNT" -eq 0 ]; then
        echo "No commits ahead of $REF"
        return 0
    fi

    echo "Found $COUNT commit(s) ahead of $REF"
    rm -rf "$OUTDIR"
    mkdir -p "$OUTDIR"

    local i=1
    for SHA in $(git log --reverse --format="%H" "$REF"..HEAD); do
        local MSG=$(git log -1 --format='%s' "$SHA")
        local SAFE=$(printf '%04d-%s' "$i" "$(echo "$MSG" | tr ' /:' '---' | tr -cd '[:alnum:]-')")
        git diff --binary "$SHA~1" "$SHA" > "$OUTDIR/$SAFE.diff"
        echo "$MSG" > "$OUTDIR/$SAFE.msg"
        echo "  [$i/$COUNT] $SAFE"
        i=$((i + 1))
    done

    if $COMPRESS; then
        tar --zstd -cf "$OUTDIR.tar.zst" "$OUTDIR"
        rm -rf "$OUTDIR"
        echo "Done → $OUTDIR.tar.zst"
    else
        echo "Done → $OUTDIR/"
    fi
}

git_time_apply() {
    local DECOMPRESS=false
    local EDIT=false
    local OPTIND opt
    while getopts "ze" opt; do
        case $opt in z) DECOMPRESS=true ;; e) EDIT=true ;; *) return 1 ;; esac
    done
    shift $((OPTIND - 1))

    local INDIR="${1:-time-machine}"

    if $DECOMPRESS; then
        tar --zstd -xf "$INDIR"
        INDIR="${INDIR%.tar.zst}"
    fi

    local DIFFS=$(ls "$INDIR"/*.diff 2>/dev/null | sort)
    local COUNT=$(echo "$DIFFS" | grep -c . || true)

    if [ "$COUNT" -eq 0 ]; then
        echo "No .diff files found in $INDIR/"
        return 1
    fi

    echo "Applying $COUNT commit(s) from $INDIR/"

    local i=1
    for DIFF in $DIFFS; do
        local BASE="${DIFF%.diff}"
        local MSG=$(cat "$BASE.msg" 2>/dev/null || basename "$BASE")

        echo "  [$i/$COUNT] $MSG"
        git apply "$DIFF"
        git add -A

        if $EDIT; then
            git commit -e -m "$MSG"
        else
            git commit -m "$MSG"
        fi
        echo "  ✓ committed"
        i=$((i + 1))
    done

    if $DECOMPRESS; then
        rm -rf "$INDIR"
    fi

    echo "Done — $COUNT commit(s) applied"
}
