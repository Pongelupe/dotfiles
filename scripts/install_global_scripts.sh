#! /bin/bash

BIN_FOLDER=$HOME/.local/bin
mkdir -p $BIN_FOLDER

for script in $DOT_FILES/scripts/global/*; do
    if [ -f "$script" ] && [ -x "$script" ]; then
        name=$(basename "$script" | sed 's/\.[^.]*$//')
        read -p "Create symlink for $(basename "$script") as $name? (y/N): " confirm
        if [[ $confirm =~ ^[Yy]$ ]]; then
            ln -sf "$script" "$BIN_FOLDER/$name"
        fi
    fi
done
