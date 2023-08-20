#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

echo $(gum style --foreground "#04B575" "[Menu - Delete Workspaces]")

if [[ -z $(grep '[^[:space:]]' $SCRIPT_CURRENT_PATH/saved-workspace.txt) ]] ; then
    # The file is empty.
    echo "You have no Workspaces saved within saved-workspace.txt (Workspace)"
    rm -f $SCRIPT_CURRENT_PATH/saved-workspace.txt
else
    WORKSPACE_TO_DELETE=$(cat $SCRIPT_CURRENT_PATH/saved-workspace.txt | gum filter)
    echo "WORKSPACE_TO_DELETE: $WORKSPACE_TO_DELETE" 
    
    gum confirm "
    Are you sure you want to delete???
    " || exit 0
    
    # Split the line with ';'
    ARRAY_WORKSPACES=(${WORKSPACE_TO_DELETE//;/ })
    # Delete all the lines that contain the 'string' (Current-Date + Workspace-Name) in the first position of array
    sed -i "/${ARRAY_WORKSPACES[0]}/d" $SCRIPT_CURRENT_PATH/saved-workspace.txt
fi