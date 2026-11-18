#!/usr/bin/env bash
# Fired by tmux 'alert-bell' hook. kiro-cli emits BEL when it needs your attention.
# Skip the popup when the terminal is already frontmost (you're watching).
front=$(lsappinfo info -only name "$(lsappinfo front)" 2>/dev/null)
case "$front" in
  *[Aa]lacritty*|*iTerm*|*Terminal*|*[Gg]hostty*|*WezTerm*) exit 0 ;;
esac
osascript -e "display notification \"Your turn 🫡\" with title \"tmux: $(tmux display -p '#S:#I #W' 2>/dev/null)\" sound name \"Glass\"" >/dev/null 2>&1
