#!/bin/sh

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

echo $(gum style --foreground "#04B575" "[Menu - Linux]")


# TODO: 
# Add Shortcut of "kubectl" in ".bashrc"
# alias k="kubectl"