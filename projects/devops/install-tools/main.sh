#!/bin/sh

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

gum style --foreground "#04B575" '[Menu - DevOps/Install-Tools]'
echo ""
echo '{{ Color "99" "0" " NOTE: " }}' | gum format -t template
echo '{{ Color "99" "0" " TODO: " }} {{ Italic "Soon will be working on this option" }}' | gum format -t template
echo ""

