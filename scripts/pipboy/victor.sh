#!/bin/bash
# 🤠 Victor — Your Pip-Boy Quest Agent
# A cheerful cowboy securitron that manages your Taskwarrior quests

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BOLD='\033[1m'
RESET='\033[0m'

victor() {
    echo "$1" | cowsay -f $PIPBOY_HOME/victor.cow -W 30
}

echo ''
echo -e " ${CYAN}═══════════════════════════════════${RESET}"
echo -e " ${BOLD} 🤠 VICTOR — Pip-Boy Quest Agent${RESET}"
echo -e " ${CYAN}═══════════════════════════════════${RESET}"
echo ''
victor "Well howdy, partner! Victor here, at your service! 🤠"
echo ''
victor "Here's what I can do for ya:"
echo -e "  ${BOLD}add${RESET} <quest>        — New quest"
echo -e "  ${BOLD}done${RESET} <id>          — Complete quest"
echo -e "  ${BOLD}start${RESET} <id>         — Start a quest"
echo -e "  ${BOLD}list${RESET}               — Show all quests"
echo -e "  ${BOLD}tag${RESET} <id> <+tag>    — Tag a quest"
echo -e "  ${BOLD}pri${RESET} <id> <H/M/L>   — Set priority"
echo -e "  ${BOLD}project${RESET} <id> <name> — Set project"
echo -e "  ${BOLD}score${RESET}              — Your stats"
echo -e "  ${BOLD}help${RESET}               — This here menu"
echo -e "  ${BOLD}quit${RESET}               — Mosey on out"
echo ''

HOWDY=(
    "Sure thing, pardner!"
    "Right away, partner!"
    "You got it, amigo!"
    "On it like a tumbleweed in a dust storm!"
    "Yeehaw, comin' right up!"
    "Well alrighty then!"
)

DONE_LINES=(
    "That quest is done and dusted! Yeehaw! 🤠"
    "Another one bites the dust, pardner! 🎯"
    "Crossed that right off the list! Keep it up! ⭐"
    "Quest complete! You're one rootin' tootin' adventurer! 🏆"
)

rand_howdy() { echo "${HOWDY[$((RANDOM % ${#HOWDY[@]}))]}"; }
rand_done() { echo "${DONE_LINES[$((RANDOM % ${#DONE_LINES[@]}))]}"; }

while true; do
    printf "${YELLOW}[You]>${RESET} "
    read -r input
    [ -z "$input" ] && continue

    cmd=$(echo "$input" | awk '{print tolower($1)}')
    rest=$(echo "$input" | cut -d' ' -f2-)

    case "$cmd" in
        quit|exit)
            victor "Happy trails, pardner! 🤠"
            break
            ;;
        list|quests|ls)
            victor "$(rand_howdy) Here's your quest log:"
            echo ''
            task rc.verbose=nothing list 2>/dev/null
            echo ''
            ;;
        add|new)
            if [ -z "$rest" ] || [ "$rest" = "$cmd" ]; then
                victor "What quest you want me to add, pardner?"
                continue
            fi
            victor "$(rand_howdy)"
            task add "$rest" 2>/dev/null
            echo ''
            ;;
        done|complete|finish)
            if [ -z "$rest" ] || [ "$rest" = "$cmd" ]; then
                victor "Which quest number did ya finish?"
                continue
            fi
            task "$rest" done 2>/dev/null
            victor "$(rand_done)"
            echo ''
            ;;
        start|begin)
            if [ -z "$rest" ] || [ "$rest" = "$cmd" ]; then
                victor "Which quest you startin', pardner?"
                continue
            fi
            task "$rest" start 2>/dev/null
            victor "Time to get to work! Let's ride! 🐎"
            echo ''
            ;;
        tag)
            id=$(echo "$rest" | awk '{print $1}')
            tags=$(echo "$rest" | cut -d' ' -f2-)
            task "$id" modify "$tags" 2>/dev/null
            victor "Tagged it up for ya, pardner!"
            echo ''
            ;;
        pri|priority)
            id=$(echo "$rest" | awk '{print $1}')
            pri=$(echo "$rest" | awk '{print $2}')
            task "$id" modify priority:"$pri" 2>/dev/null
            victor "Priority set! That quest just got more important!"
            echo ''
            ;;
        project|proj)
            id=$(echo "$rest" | awk '{print $1}')
            proj=$(echo "$rest" | awk '{print $2}')
            task "$id" modify project:"$proj" 2>/dev/null
            victor "Filed under $proj, pardner!"
            echo ''
            ;;
        score|stats|xp)
            victor "Let me check the scoreboard..."
            echo ''
            tq -v 2>/dev/null
            echo ''
            ;;
        help|h|\?)
            victor "Here's what I can do for ya:"
            echo -e "  ${BOLD}add${RESET} <quest>        — New quest"
            echo -e "  ${BOLD}done${RESET} <id>          — Complete quest"
            echo -e "  ${BOLD}start${RESET} <id>         — Start a quest"
            echo -e "  ${BOLD}list${RESET}               — Show all quests"
            echo -e "  ${BOLD}tag${RESET} <id> <+tag>    — Tag a quest"
            echo -e "  ${BOLD}pri${RESET} <id> <H/M/L>   — Set priority"
            echo -e "  ${BOLD}project${RESET} <id> <name> — Set project"
            echo -e "  ${BOLD}score${RESET}              — Your stats"
            echo -e "  ${BOLD}quit${RESET}               — Mosey on out"
            echo ''
            ;;
        *)
            # Pass anything else straight to task
            victor "Runnin' that for ya, pardner..."
            task $input 2>/dev/null
            echo ''
            ;;
    esac
done
