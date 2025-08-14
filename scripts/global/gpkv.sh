#! /bin/bash

while read -r line;
do
    mode=$(echo "$line" | cut -c1)
    file=$(echo "$line" | cut -c3- | xargs | sed "s|^|$(git rev-parse --show-toplevel)/|")
    if [[ "$mode" !=  "M" ]] || git diff --quiet "$file"; then
        echo "Ignoring File: $file"
        continue
    fi
    echo "File: $file"
    git --no-pager diff "$file"
    read -p "Action ([p]aga, [k]ika ou [v]inga, [q]uit): " action </dev/tty
    case $action in
        p) git add "$file" ;;
        k) git restore "$file" ;;
        v) ;;
        q) exit 0;;
    esac
done < <(git status --porcelain)
