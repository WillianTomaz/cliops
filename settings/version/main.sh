#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

gum style --foreground "#04B575" '[Menu - Settings/Version]'

VAR_REPO="WillianTomaz/cliops"
VAR_LATEST_RELEASE_VERSION_IN_GITHUB=$(curl --silent "https://api.github.com/repos/$VAR_REPO/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')


VAR_CURRENT_VERSION_IN_LOCAL_REPO=$(git tag --sort=committerdate | tail -1)

if [ "$VAR_LATEST_RELEASE_VERSION_IN_GITHUB" == "$VAR_CURRENT_VERSION_IN_LOCAL_REPO" ]; then
    echo ""
    echo '{{ Color "99" "0" " RELEASE NOTE: " }} {{ Italic "Everything is up to date!" }}' | gum format -t template
    echo ""
else
    echo ""
    echo '{{ Color "99" "0" " RELEASE NOTE: " }} {{ Italic "You need to update!" }}' | gum format -t template
    echo ""
fi
