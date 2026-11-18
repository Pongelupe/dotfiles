#!/bin/bash
# 📊 Pip-Boy Stats Display

GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

pending=$(task rc.verbose=nothing count status:pending 2>/dev/null)
completed=$(task rc.verbose=nothing count status:completed 2>/dev/null)
total=$((pending + completed))
[ "$total" -eq 0 ] && pct=0 || pct=$((completed * 100 / total))

# XP: 10 per completed task
xp=$((completed * 10))
# Level: every 50 XP
level=$((xp / 50 + 1))
xp_in_level=$((xp % 50))

# Progress bar for level
bar_len=20
filled=$((xp_in_level * bar_len / 50))
empty=$((bar_len - filled))
level_bar=$(printf "%${filled}s" | tr ' ' '█')$(printf "%${empty}s" | tr ' ' '░')

# Quest completion bar
if [ "$total" -eq 0 ]; then
    quest_filled=0
else
    quest_filled=$((pct * bar_len / 100))
fi
quest_empty=$((bar_len - quest_filled))
quest_bar=$(printf "%${quest_filled}s" | tr ' ' '█')$(printf "%${quest_empty}s" | tr ' ' '░')

# Today's completed
today=$(date +%Y-%m-%d)
today_done=$(task rc.verbose=nothing end.after:today count 2>/dev/null)

# Tags (user tags only, exclude virtual ones)
tags=$(task rc.verbose=nothing _tags 2>/dev/null | grep -v '^[A-Z]' | grep -v '^next$' | grep -v '^nocal$' | grep -v '^nocolor$' | grep -v '^nonag$' | tr '\n' ' ')

echo ""
echo -e " ${CYAN}╔═══════════════════════════╗${RESET}"
echo -e "${CYAN} ║${RESET}  ${BOLD}📟 P I P - B O Y  3000   ${RESET}${CYAN}║${RESET}"
echo -e " ${CYAN}╚═══════════════════════════╝${RESET}"
echo ""
echo -e " ${YELLOW}⚡ LEVEL ${level}${RESET}"
echo -e " ${GREEN}${level_bar}${RESET} ${xp_in_level}/50 XP"
echo -e " ${DIM}Total XP: ${xp}${RESET}"
echo ""
echo -e " ${CYAN}═══ QUEST STATUS ═══${RESET}"
echo -e " Active:    ${BOLD}${pending}${RESET}"
echo -e " Completed: ${GREEN}${completed}${RESET}"
echo -e " ${quest_bar} ${pct}%"
echo ""
echo -e " ${CYAN}═══ TODAY ═══${RESET}"
echo -e " Quests cleared: ${GREEN}${today_done}${RESET}"
echo ""
echo -e " ${CYAN}═══ PROJECTS ═══${RESET}"
task rc.verbose=nothing summary 2>/dev/null | tail -n +2 | head -10 | while IFS= read -r line; do
    [ -z "$line" ] && continue
    echo -e " ${DIM}${line}${RESET}"
done
echo ""
echo -e " ${CYAN}═══ KNOWN TAGS ═══${RESET}"
echo -e " ${DIM}${tags}${RESET}"
echo ""
echo -e " ${DIM}$(date '+%Y-%m-%d %H:%M')${RESET}"
