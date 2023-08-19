#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
VAR_ROOT_PATH=$1
# ---------------------------------------

# Linux Presentation
gum style --foreground "#04B575" '[Menu - Settings] What you want to do?'

MY_CHOICE=$(cat $SCRIPT_CURRENT_PATH/settings-menu.txt | gum choose)
PATH_TO_THE_CHOSEN_PROJECT="$SCRIPT_CURRENT_PATH/$MY_CHOICE/main.sh"

if [ $MY_CHOICE == "[exit]" ]; then
    clear
    exit 0
elif [ $MY_CHOICE == "set-options" ]; then
    bash $PATH_TO_THE_CHOSEN_PROJECT $VAR_ROOT_PATH
else
    bash $PATH_TO_THE_CHOSEN_PROJECT
fi