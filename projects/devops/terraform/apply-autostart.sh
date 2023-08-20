#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
VAR_WORKSPACE_NAME=$1
VAR_TFVARS_NAME=$2
# ---------------------------------------

gum style --foreground "#04B575" '[Menu - Terraform/Auto-Start] Applying Autosaving Chosen...'

terraform workspace select $VAR_WORKSPACE_NAME

echo "----------------------------------------------------------"
# Show Current Workspace
VAR_CURRENT_WORKSPACE=$(terraform workspace show)
gum format --type markdown -- "#### INFORMATION ABOUT CURRENT WORKSPACE:" "- $VAR_CURRENT_WORKSPACE"

gum spin --spinner line \
--title "Wait... Going back to menu..." \
-- sleep 3

bash $SCRIPT_CURRENT_PATH/main.sh $VAR_TFVARS_NAME