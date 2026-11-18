#!/bin/bash

for file in "$DOT_FILES"/.aliases*; do
	ln -sfn "$file" "$HOME/$(basename "$file")"
done

mkdir -p "$HOME/.config"
for file in "$DOT_FILES"/.config/*; do
	ln -sfn "$file" "$HOME/.config/$(basename "$file")" 
done

ln -sfn "$DOT_FILES/.tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$DOT_FILES/.exports" "$HOME/.exports"
ln -sfn "$DOT_FILES/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$DOT_FILES/.path" "$HOME/.path"
ln -sfn "$DOT_FILES/secrets/.ssh" "$HOME/.ssh"
ln -sfn "$DOT_FILES/.vim" "$HOME/.vim"
ln -sfn "$DOT_FILES/.vimrc" "$HOME/.vimrc"
ln -sfn "$DOT_FILES/.zshrc" "$HOME/.zshrc"

