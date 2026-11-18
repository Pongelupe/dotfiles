#!/bin/bash
# 🖥️ PIP-BOY — Your personal quest terminal
# Launch: pipboy

WIN="pipboy"

# Create new window with taskwarrior TUI
tmux new-window -n "$WIN"
tmux send-keys -t "$WIN" "taskwarrior-tui" Enter

# Right pane: live stats
tmux split-window -t "$WIN" -h -l 69
tmux send-keys -t "$WIN" 'watch -t -n 10 --color $PIPBOY_HOME/pipboy-stats.sh' Enter

# Mid-right: Victor cowsay greeting (static)
tmux split-window -t "$WIN" -v -l 61
tmux send-keys -t "$WIN" "echo Howdy pardner! | cowsay -f $PIPBOY_HOME/victor.cow -W 30 && kiro-cli chat --agent victor 'Howdy'" Enter

# Focus on Victor AI
tmux select-pane -t "$WIN".3
