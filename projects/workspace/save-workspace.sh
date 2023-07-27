#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

echo $(gum style --foreground "#04B575" "[Menu - Save Workspaces]")

echo '{{ Color "99" "0" " NOTE: " }}' | gum format -t template
echo '{{ Color "99" "0" " 1 - " }} {{ Italic "Write a workspace name with: '-'." }} {{ Color "95" "0" " Example: my-save " }}' | gum format -t template
echo '{{ Color "99" "0" " 2 - " }} {{ Italic "The branch name must be the same as what was created in your repository." }} {{ Color "95" "0" " Example: feat-branch" }}' | gum format -t template
echo '{{ Color "99" "0" " 3 - " }} {{ Italic "The description is to help you remember what you were working on earlier." }} {{ Color "95" "0" " Example: I need to finish making this workspace input " }}' | gum format -t template

CURRENT_DATE=$(date '+%Y%m%d-%H%M%S')

CURRENT_DIR=${PWD}
SAVE_NAME=$(gum input --placeholder "Name of the workspace you want to save?" --value "my-save")
BRANCH_NAME=$(gum input --placeholder "What's the git branch name?" --value "feat-branch")
DESCRIPTION=$(gum input --placeholder "Do you have any description?" --value "Need to Finish this")

echo "Script executed from: ${CURRENT_DIR}"

# if branch_name was not filled in, do not save in the file and warn
if [ -z "$SAVE_NAME" ] ; then
    echo '{{ Color "99" "0" " *** " }} {{ Italic "Required fields: 'SAVE_NAME'" }}' | gum format -t template
    exit 0
fi
if [ -z "$BRANCH_NAME" ] ; then
    echo '{{ Color "99" "0" " *** " }} {{ Italic "Required fields: 'BRANCH_NAME'" }}' | gum format -t template
    exit 0
fi

# Saving workspace data to file
echo "${CURRENT_DATE}-${SAVE_NAME};${CURRENT_DIR};${BRANCH_NAME};${DESCRIPTION}" >> $SCRIPT_CURRENT_PATH/saved-workspace.txt

