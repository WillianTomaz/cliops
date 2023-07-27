#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

echo $(gum style --foreground "#04B575" "[Menu - Workspaces]")


MY_CHOICE=$(gum choose "save" "restore" "delete")
echo "My Choice: $MY_CHOICE" 

if [ "$MY_CHOICE" == "save" ]; then
    # Save
    bash $SCRIPT_CURRENT_PATH/save-workspace.sh
elif [ "$MY_CHOICE" == "restore" ]; then
    # Restore
    bash $SCRIPT_CURRENT_PATH/restore-workspace.sh
else
    # Delete
    bash $SCRIPT_CURRENT_PATH/delete-workspace.sh
fi

sleep 1