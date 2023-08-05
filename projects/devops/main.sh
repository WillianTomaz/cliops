#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

# DevOps Presentation
gum style --foreground "#04B575" '[Menu - DevOps]'

# Show the list of projects to choose from
#       "projects-menu.txt" -> Has a list of folder names of the projects
MY_CHOICE=$(cat $SCRIPT_CURRENT_PATH/projects-menu.txt | gum choose)

PATH_TO_THE_CHOSEN_PROJECT="$SCRIPT_CURRENT_PATH/$MY_CHOICE/main.sh"

if [ $MY_CHOICE == "[exit]" ]; then
    clear
    exit 0
else
    # Setting up the project address to run its main.sh file
    bash $PATH_TO_THE_CHOSEN_PROJECT
fi