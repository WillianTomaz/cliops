#!/bin/bash
# Dependency:
#  - Install `gum` by following the instructions in: https://github.com/charmbracelet/gum#installation
#    gum version v0.11.0 (f5b09a4)

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

# Main Presentation
gum style \
	--foreground 45 --border-foreground 45 --border rounded --padding "2 4" \
	'This is a CLI OPS :)' \
    'To help you automate some stuff'

MY_CHOICE=$(cat $SCRIPT_CURRENT_PATH/projects-menu.txt | gum choose)

if [ $MY_CHOICE == "[exit]" ]; then
    clear
    exit 0
elif [ $MY_CHOICE == "settings" ]; then
    PATH_TO_THE_CHOSEN_PROJECT="$SCRIPT_CURRENT_PATH/$MY_CHOICE/main.sh"
    bash $PATH_TO_THE_CHOSEN_PROJECT $SCRIPT_CURRENT_PATH
else
    PATH_TO_THE_CHOSEN_PROJECT="$SCRIPT_CURRENT_PATH/projects/$MY_CHOICE/main.sh"
    bash $PATH_TO_THE_CHOSEN_PROJECT
fi

