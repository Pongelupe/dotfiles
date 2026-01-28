# !/bin/bash

for file in "$DOT_FILES"/.aliases*; do
	ln -sf "$file" "$HOME/$(basename "$file")"
done

mkdir -p "$HOME/.config"
for file in "$DOT_FILES"/.config/*; do
	ln -sf "$file" "$HOME/.config/$(basename "$file")" 
done

ln -sf "$DOT_FILES/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOT_FILES/.exports" "$HOME/.exports"
ln -sf "$DOT_FILES/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOT_FILES/.path" "$HOME/.path"
ln -sf "$DOT_FILES/secrets/.ssh" "$HOME/.ssh"
ln -sf "$DOT_FILES/.vim" "$HOME/.vim"
ln -sf "$DOT_FILES/.vimrc" "$HOME/.vimrc"
ln -sf "$DOT_FILES/.zshrc" "$HOME/.zshrc"

