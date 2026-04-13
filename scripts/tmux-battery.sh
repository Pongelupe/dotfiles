#!/usr/bin/env bash
# Show battery only when not fully charged
pmset -g batt | grep -q "charged" && exit 0
~/.tmux/plugins/tmux-battery/scripts/battery_percentage.sh
echo -n " "
~/.tmux/plugins/tmux-battery/scripts/battery_icon_charge.sh
echo -n " "
