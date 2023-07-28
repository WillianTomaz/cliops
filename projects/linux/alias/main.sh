#!/bin/sh

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

echo $(gum style --foreground "#04B575" "[Menu - Linux/Alias] ")


# TODO: 
# Add Shortcut of "kubectl" in ".bashrc"
# alias k="kubectl"

ALIAS_NAME=$(gum input --placeholder "What is your alias key? (Ex: ll)")
ALIAS_VALUE=$(gum input --placeholder "What is your alias value? (Ex: ls -la)")

gum style --foreground 45 'LINUX -> Your alias looks like this:'
echo "alias $ALIAS_NAME='$ALIAS_VALUE'"

gum confirm "
Are you sure you want to add in '~/.bashrc'??? 
" || exit 0

echo "alias $ALIAS_NAME='$ALIAS_VALUE'" >> ~/.bashrc
source ~/.bashrc
