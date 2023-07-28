#!/bin/sh

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

# Linux Presentation
gum style --foreground 45 'LINUX -> What you want to do?'

# Show the list of projects to choose from
#       "projects-menu.txt" -> Has a list of folder names of the projects
MY_CHOICE=$(cat $SCRIPT_CURRENT_PATH/projects-menu.txt | gum choose)
# sleep 1

MENU_CHOICES_LIST=$(cat $SCRIPT_CURRENT_PATH/projects-menu.txt)
declare -A menu_to_path
for CHOICE_ITEM in $MENU_CHOICES_LIST
do
    menu_to_path["$CHOICE_ITEM"]="$SCRIPT_CURRENT_PATH/$CHOICE_ITEM/main.sh"
done

# Setting up the project address to run its main.sh file
PATH_TO_THE_CHOSEN_PROJECT=${menu_to_path[$MY_CHOICE]}
bash $PATH_TO_THE_CHOSEN_PROJECT

# bash $SCRIPT_CURRENT_PATH/alias/alias.sh
# bash $SCRIPT_CURRENT_PATH/git/commit.sh