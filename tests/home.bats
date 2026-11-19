#!/usr/bin/env bats
# Applies the repo into a throwaway $HOME with chezmoi and checks what lands there.
# Run from anywhere: bats tests/

setup() {
  export HOME="$BATS_TEST_TMPDIR/home"
  mkdir -p "$HOME"
  chezmoi --source "$BATS_TEST_DIRNAME/.." --destination "$HOME" \
    --config "$BATS_TEST_TMPDIR/chezmoi.toml" \
    --persistent-state "$BATS_TEST_TMPDIR/state.boltdb" \
    apply --force --exclude=externals
}

@test "configs land in \$HOME" {
  for f in .zshrc .vimrc .tmux.conf .exports .path .gitconfig \
           .aliases .aliases.git .aliases.dev .aliases.docker \
           .vim/coc-settings.json .vim/colors/gotham.vim .vim/spell/pt.utf-8.spl \
           .config/alacritty/alacritty.toml .config/navi/config.yaml \
           .config/navi/cheats/vim-kotlin-lsp.cheat .config/cheat/conf.yml \
           .config/zsh/completions/_aliases; do
    [ -f "$HOME/$f" ] || { echo "missing: $f"; return 1; }
  done
}

@test "empty files are kept (vim-ditto word list)" {
  [ -f "$HOME/.vim/Ditto/dittofile.txt" ]
}

@test "repo-only files stay out of \$HOME" {
  for f in README.md Makefile tests scripts secrets build ventoy home .chezmoiroot; do
    [ ! -e "$HOME/$f" ] || { echo "leaked: $f"; return 1; }
  done
}

@test "linux-only configs are skipped on macOS" {
  [ "$(uname)" = "Darwin" ] || skip "macOS only"
  for d in sway foot input-remapper-2; do
    [ ! -e "$HOME/.config/$d" ] || { echo "deployed on macOS: $d"; return 1; }
  done
}

@test "linux-only configs are deployed on Linux" {
  [ "$(uname)" = "Linux" ] || skip "Linux only"
  for f in sway/config foot/foot.ini input-remapper-2/config.json; do
    [ -f "$HOME/.config/$f" ] || { echo "missing: $f"; return 1; }
  done
}

@test "zsh loads completions from ~/.config/zsh/completions" {
  grep -qxF 'fpath=($HOME/.config/zsh/completions $fpath)' "$HOME/.zshrc"
}

@test "cheat paths point at this machine's home" {
  grep -qF "path: $HOME/.config/cheat/cheatsheets/personal" "$HOME/.config/cheat/conf.yml"
  ! grep -q '/Users/ppong' "$HOME/.config/cheat/conf.yml"
}

@test "shell files parse" {
  for f in .zshrc .exports .path .aliases .aliases.git .aliases.dev .aliases.docker; do
    zsh -n "$HOME/$f" || { echo "syntax error: $f"; return 1; }
  done
}

@test "chezmoi init remembers this checkout as the source" {
  chezmoi init --source "$BATS_TEST_DIRNAME/.." --destination "$HOME" \
    --config "$BATS_TEST_TMPDIR/init.toml" \
    --persistent-state "$BATS_TEST_TMPDIR/init.boltdb"
  [ "$(chezmoi --config "$BATS_TEST_TMPDIR/init.toml" --persistent-state "$BATS_TEST_TMPDIR/init.boltdb" source-path)" \
    = "$(cd "$BATS_TEST_DIRNAME/.." && pwd)/home" ]
}
