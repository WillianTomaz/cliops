#!/bin/sh

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------


bash $SCRIPT_CURRENT_PATH/alias/alias.sh

bash $SCRIPT_CURRENT_PATH/git/commit.sh