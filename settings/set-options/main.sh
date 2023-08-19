#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
VAR_ROOT_PATH=$1
# ---------------------------------------

# Linux Presentation
gum style --foreground "#04B575" '[Menu - Set-Options] What you want to do?'
echo ""
echo '{{ Color "99" "0" " CLIOPS-SETTINGS: " }} {{ Italic "Here you can adjust which options can appear in your CliOps start menu" }}' | gum format -t template
echo '{{ Color "99" "0" " NOTE: " }} {{ Italic "Use the [space key] to select options, then hit enter!" }}' | gum format -t template
echo ""

VAR_MY_CHOICE=$(gum choose "edit" "[exit]")

if [ $VAR_MY_CHOICE == "[exit]" ]; then
    clear
    exit 0
else
    VAR_MY_CHOICE_OPTIONS_MENU=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit "devops" "linux" "workspace")
    
fi

if [ -z "${VAR_MY_CHOICE_OPTIONS_MENU}" ]; then
    echo '{{ Color "99" "0" " WARNING: " }} {{ Italic "You must choose at least one menu option" }}' | gum format -t template
    echo ""
    
    gum spin --spinner line \
    --title "Wait going back to the settings menu..." \
    -- sleep 3
    
    bash $VAR_ROOT_PATH/settings/main.sh $VAR_ROOT_PATH
else

    echo "${VAR_MY_CHOICE_OPTIONS_MENU}" > $VAR_ROOT_PATH/projects-menu.txt
    echo -e "settings\n[exit]" >> $VAR_ROOT_PATH/projects-menu.txt

    echo '{{ Color "99" "0" " INFO: " }} {{ Italic "Your changes will appear the next time you call CliOps" }}' | gum format -t template
    echo ""
    gum spin --spinner line \
    --title "Successfully applied changes..." \
    -- sleep 3
    exit 0
fi

# if [ "$MY_CHOICE" == "save" ]; then
#     # Save
#     bash $SCRIPT_CURRENT_PATH/save-workspace.sh
# elif [ "$MY_CHOICE" == "restore" ]; then
#     # Restore
#     bash $SCRIPT_CURRENT_PATH/restore-workspace.sh
# elif [ "$MY_CHOICE" == "delete" ]; then
#     # Exit
#     bash $SCRIPT_CURRENT_PATH/delete-workspace.sh
# else
#     clear
#     exit 0
# fi


# PATH_TO_THE_CHOSEN_PROJECT="$SCRIPT_CURRENT_PATH/$MY_CHOICE/main.sh"

# if [ $MY_CHOICE == "[exit]" ]; then
#     clear
#     exit 0
# else
#     # Setting up the project address to run its main.sh file
#     bash $PATH_TO_THE_CHOSEN_PROJECT
# fi