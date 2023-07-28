#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

echo $(gum style --foreground "#04B575" "[Restore - Workspaces]")


if [[ -z $(grep '[^[:space:]]' $SCRIPT_CURRENT_PATH/saved-workspace.txt) ]] ; then
    # The file is empty.
    echo "You have no Workspaces saved within the saved-workspace.txt (Workspace)"
    rm -f $SCRIPT_CURRENT_PATH/saved-workspace.txt
else
    WORKSPACE_TO_RESTORE=$(cat $SCRIPT_CURRENT_PATH/saved-workspace.txt | gum filter)
    echo "WORKSPACE_TO_RESTORE: $WORKSPACE_TO_RESTORE" 

    # Split the line with ';'
    VAR_WORKSPACE=$(echo $WORKSPACE_TO_RESTORE | cut -d';' -f1)
    VAR_DIRECTORY=$(echo $WORKSPACE_TO_RESTORE | cut -d';' -f2)
    VAR_BRANCH=$(echo $WORKSPACE_TO_RESTORE | cut -d';' -f3)
    VAR_DESCRIPTION=$(echo $WORKSPACE_TO_RESTORE | cut -d';' -f4)

    gum format --type markdown -- "# WORKSPACE CHOSEN FOR TO RESTORE:" "- WORKSPACE: $VAR_WORKSPACE" "- DIRECTORY: $VAR_DIRECTORY" "- BRANCH: $VAR_BRANCH" "- DESCRIPTION: $VAR_DESCRIPTION"
    echo "----------------------------------------------------------"

    # Change to Directory
    cd $VAR_DIRECTORY
    
    # Change to branch (if not have chages in current branch)
    if [[ `git status --porcelain --untracked-files=no` ]]; then
        GIT_CHANGE=$(echo "Has Changes: $(git status --porcelain --untracked-files=no)")
    else
        GIT_CHANGE=$(echo "No has changes")
    fi

    # TODO: GIVE THE OPTION TO CHOOSE IF YOU WANT TO RESET/CHECKOUT

    gum confirm "
    Are you sure you want to restore to this saved workspace??? 
    Note: You may lose your uncommitted data.
    " || exit 0

    gum format --type markdown -- "# CHANGING DIRECTORY:" "- CHANGES: $GIT_CHANGE" "- DIRECTORY: $VAR_DIRECTORY" "- CHECKOUT: $VAR_BRANCH" "- DESCRIPTION: $VAR_DESCRIPTION"
    echo "----------------------------------------------------------"

    bash $SCRIPT_CURRENT_PATH/go-to.sh $VAR_DIRECTORY $SCRIPT_CURRENT_PATH $VAR_BRANCH

fi