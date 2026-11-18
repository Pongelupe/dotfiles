#!/usr/bin/env bash

execute_last_command() {
  local cmd="$(fc -ln -1)"
  echo "executing: $cmd"
  eval "$cmd"
}

print_full_path_from_relative() {
  relative_path=$1
  echo "$(pwd)/$relative_path"
}

copy_full_path_from_relative() {
  print_full_path_from_relative $1 | pbcopy
}

pipboy() {
  if tmux list-windows -F '#W' 2>/dev/null | grep -q '^pipboy$'; then
    tmux select-window -t pipboy
  else
    $PIPBOY_HOME/pipboy.sh
  fi
}
