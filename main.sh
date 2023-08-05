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

# Show the list of projects to choose from
#       "projects-menu.txt" -> Has a list of folder names of the projects
MY_CHOICE=$(cat $SCRIPT_CURRENT_PATH/projects-menu.txt | gum choose)

PATH_TO_THE_CHOSEN_PROJECT="$SCRIPT_CURRENT_PATH/projects/$MY_CHOICE/main.sh"

if [ $MY_CHOICE == "[exit]" ]; then
    clear
    exit 0
else
    # Setting up the project address to run its main.sh file
    bash $PATH_TO_THE_CHOSEN_PROJECT
fi

