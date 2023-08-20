

function func_get_values_autostart () {
    local VAR_AUTOSTART_TO_APPLY=$(cat $1/saved-auto-start.txt | gum filter)
    echo "VAR_AUTOSTART_TO_APPLY: $VAR_AUTOSTART_TO_APPLY"

    # Split the line with ';'
    local VAR_AUTOSTART_NAME=$(echo $VAR_AUTOSTART_TO_APPLY | cut -d';' -f1)
    local VAR_DIRECTORY=$(echo $VAR_AUTOSTART_TO_APPLY | cut -d';' -f2)
    local VAR_WORKSPACE_NAME=$(echo $VAR_AUTOSTART_TO_APPLY | cut -d';' -f3)
    local VAR_TFVARS_NAME=$(echo $VAR_AUTOSTART_TO_APPLY | cut -d';' -f4)

    gum format --type markdown -- "# AUTOSAVING CHOSEN FOR TO APPLYING:" "- AUTOSTART: $VAR_AUTOSTART_NAME" "- DIRECTORY: $VAR_DIRECTORY" "- WORKSPACE: $VAR_WORKSPACE_NAME" "- TFVARS: $VAR_TFVARS_NAME"
    echo "----------------------------------------------------------"

    RES_FUNC_GVA_DIRECTORY=$VAR_DIRECTORY
    RES_FUNC_GVA_WORKSPACE_NAME=$VAR_WORKSPACE_NAME
    RES_FUNC_GVA_TFVARS_NAME=$VAR_TFVARS_NAME
}

# TO OBTAIN THE RESULT BY THE VARIABLE 'RES_FUNC_GVA'
# source $SCRIPT_CURRENT_PATH/get-autostart.sh
# func_get_values_autostart $SCRIPT_CURRENT_PATH
# echo $RES_FUNC_GVA
