#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
$VAR_TFVARS_NAME=$1
# ---------------------------------------


# if [[ -z $(grep '[^[:space:]]' $SCRIPT_CURRENT_PATH/saved-auto-start.txt) ]] ; then
#     # The file is empty.
#     echo "NÃO DADOS NO ARQUIVO: saved-auto-start.txt"
# else
#     gum confirm "
#     Do you want to continue ???
#     " || exit 0
#     echo "TEM DADOS NO ARQUIVO: saved-auto-start.txt"
#     source $SCRIPT_CURRENT_PATH/get-autostart.sh
#     func_get_values_autostart $SCRIPT_CURRENT_PATH
#     echo $func_gva_result
# fi

gum style --foreground "#04B575" '[Menu - DevOps/Terraform]'
echo ""
echo '{{ Color "99" "0" " NOTE: " }}' | gum format -t template
echo '{{ Color "99" "0" " (Important) " }} {{ Italic "To be able to use this module in the CLI, you need to have terraform configured on your machine!" }}' | gum format -t template
echo ""

MY_CMD_CHOICE=$(gum choose "init" "plan" "apply" "destroy" "workspace" "auto_start" "[exit]")

if [ "$MY_CMD_CHOICE" == "init" ]; then
    MY_CMD_SUB_CHOICE=$(gum choose "init" "init_reconfigure")
    
    gum confirm "
    Do you want to continue ???
    " || exit 0

    if [ "$MY_CMD_SUB_CHOICE" == "init_reconfigure" ]; then
        terraform init -reconfigure
    else
        terraform init
    fi


elif [ "$MY_CMD_CHOICE" == "plan" ]; then
    gum confirm "
    Do you want to continue ???
    " || exit 0
    
    terraform plan

elif [ "$MY_CMD_CHOICE" == "apply" ]; then
    MY_CMD_SUB_CHOICE=$(gum choose "apply" "apply_auto_approve")

    gum confirm "
    Do you want to continue ???
    " || exit 0

    if [ "$MY_CMD_SUB_CHOICE" == "apply_auto_approve" ]; then
        terraform apply -auto-approve
    else
        terraform apply
    fi


elif [ "$MY_CMD_CHOICE" == "destroy" ]; then
    MY_CMD_SUB_CHOICE=$(gum choose "destroy" "destroy_auto_approve")
    
    gum confirm "
    Do you want to continue ???
    " || exit 0

    if [ "$MY_CMD_SUB_CHOICE" == "destroy_auto_approve" ]; then
        terraform destroy -auto-approve
    else
        terraform destroy
    fi

elif [ "$MY_CMD_CHOICE" == "workspace" ]; then
    # Show Current Workspace
    VAR_CURRENT_WORKSPACE=$(terraform workspace show)
    gum format --type markdown -- "#### INFORMATION ABOUT CURRENT WORKSPACE:" "- $VAR_CURRENT_WORKSPACE"
    echo "----------------------------------------------------------"

    MY_CMD_SUB_CHOICE=$(gum choose "list" "new" "select" "delete" "[exit]")
    if [ "$MY_CMD_SUB_CHOICE" == "list" ]; then
        terraform workspace list
    elif [ "$MY_CMD_SUB_CHOICE" == "new" ]; then
        WORKSPACE_NAME=$(gum input --placeholder "Name of the workspace you want to create?")
        terraform workspace new $WORKSPACE_NAME
    elif [ "$MY_CMD_SUB_CHOICE" == "select" ]; then
        MY_TF_LIST_CHOICE=$(terraform workspace list | gum choose)
        terraform workspace select $MY_TF_LIST_CHOICE
    elif [ "$MY_CMD_SUB_CHOICE" == "delete" ]; then
        MY_TF_DELETE_CHOICE=$(terraform workspace list | gum choose)
        terraform workspace delete $MY_TF_DELETE_CHOICE
    else
        clear
        exit 0
    fi

elif [ "$MY_CMD_CHOICE" == "auto_start" ]; then
    bash $SCRIPT_CURRENT_PATH/main-autostart.sh

else
    clear
    exit 0
fi
