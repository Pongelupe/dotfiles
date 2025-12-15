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
