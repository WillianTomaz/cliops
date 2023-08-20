#!/bin/bash

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

func_back_to_menu () {
    gum spin --spinner line \
    --title "Wait... Going back to menu..." \
    -- sleep 3
    
    bash $SCRIPT_CURRENT_PATH/main-autostart.sh
}


gum style --foreground "#04B575" '[Menu - Terraform/Auto-Start] What you want to do?'

VAR_MY_CHOICE=$(gum choose "select" "create" "delete" "[exit]")

if [ $VAR_MY_CHOICE == "select" ]; then

    if [ -e "$SCRIPT_CURRENT_PATH/saved-auto-start.txt" ]; then         
        source $SCRIPT_CURRENT_PATH/get-autostart.sh
        func_get_values_autostart $SCRIPT_CURRENT_PATH

        # TODO: CONTINUAR AQUI, PRECISA FAZER:
        # A PARTE QUE FARIA O CD PARA O PROJETO (UTILIZAR O GO-TO.SH -> TALVÉS NÃO VAI FUNCIONAR PORQUE APÓS FEITO O CD ELE NÃO VAI ESTAR MAIS RODANDO O CLI, TALVÉZ PRECISE ESTAR NO DIRETORIO)
        # ENTRAR NO WORKSPACE QUE FOI DESCRITO NO SAVED-AUTO-START
        gum confirm "
        Do you want to continue ???
        " || exit 0

        bash $SCRIPT_CURRENT_PATH/go-to.sh $RES_FUNC_GVA_DIRECTORY $SCRIPT_CURRENT_PATH $RES_FUNC_GVA_WORKSPACE_NAME $RES_FUNC_GVA_TFVARS_NAME
        
    else
        echo ""
        echo '{{ Color "99" "0" " ERROR: " }} {{ Italic "You have no saved records yet." }} {{ Color "95" "0" " Run the create option first " }}' | gum format -t template
        echo ""

        func_back_to_menu
    fi


elif [ $VAR_MY_CHOICE == "create" ]; then
        
    echo '{{ Color "99" "0" " NOTE: " }}' | gum format -t template
    echo '{{ Color "99" "0" " 1 - " }} {{ Italic "Write a name for the autostart with: '-'." }} {{ Color "95" "0" " Example: my-autostart " }}' | gum format -t template
    echo '{{ Color "99" "0" " 2 - " }} {{ Italic "The Terraform workspace name must be the same as what was created in your project Terraform." }} {{ Color "95" "0" " Example: my_workspace" }}' | gum format -t template
    echo '{{ Color "99" "0" " 3 - " }} {{ Italic "The address to the '.tfvars' file must be mapped from the main.tf file of the terraform folder." }} {{ Color "95" "0" " Example: env/dev.tfvars " }}' | gum format -t template

    CURRENT_DATE=$(date '+%Y%m%d-%H%M%S')

    CURRENT_DIR=${PWD}
    echo "Script executed from: ${CURRENT_DIR}"
    
    FILES_COUNT=`ls -1 *.tf 2>/dev/null | wc -l`
    if [ $FILES_COUNT == 0 ]; then
        echo ""
        echo '{{ Color "99" "0" " ERROR " }} {{ Italic "The current directory does not have any Terraform(.tf) files, enter the Terraform project directory" }}' | gum format -t template
        echo ""

        func_back_to_menu
    else
        AUTOSTART_NAME=$(gum input --placeholder "What name for autostart?" --value "my-autostart")
        WORKSPACE_NAME=$(gum input --placeholder "What is the name of the terraform workspace?" --value "my_workspace")
        TFVARS_NAME=$(gum input --placeholder "What is the address to the '.tfvars'?" --value "env/dev.tfvars")


        # if branch_name was not filled in, do not save in the file and warn
        if [ -z "$AUTOSTART_NAME" ] ; then
            echo '{{ Color "99" "0" " *** " }} {{ Italic "Required fields: 'AUTOSTART_NAME'" }}' | gum format -t template
            exit 0
        fi
        if [ -z "$WORKSPACE_NAME" ] ; then
            echo '{{ Color "99" "0" " *** " }} {{ Italic "Required fields: 'WORKSPACE_NAME'" }}' | gum format -t template
            exit 0
        fi
        if [ -z "$TFVARS_NAME" ] ; then
            echo '{{ Color "99" "0" " *** " }} {{ Italic "Required fields: 'TFVARS_NAME'" }}' | gum format -t template
            exit 0
        fi

        # Saving workspace data to file
        echo "${CURRENT_DATE}-${AUTOSTART_NAME};${CURRENT_DIR};${WORKSPACE_NAME};${TFVARS_NAME}" >> $SCRIPT_CURRENT_PATH/saved-auto-start.txt
    fi

elif [ $VAR_MY_CHOICE == "delete" ]; then
    if [[ -z $(grep '[^[:space:]]' $SCRIPT_CURRENT_PATH/saved-auto-start.txt) ]] ; then
        # The file is empty.
        echo "You have no Workspaces saved within saved-auto-start.txt (Workspace)"
        rm -f $SCRIPT_CURRENT_PATH/saved-auto-start.txt
    else
        AUTOSTART_TO_DELETE=$(cat $SCRIPT_CURRENT_PATH/saved-auto-start.txt | gum filter)
        echo "AUTOSTART_TO_DELETE: $AUTOSTART_TO_DELETE" 
        
        gum confirm "
        Are you sure you want to delete???
        " || exit 0
        
        # Split the line with ';'
        ARRAY_WORKSPACES=(${AUTOSTART_TO_DELETE//;/ })
        # Delete all the lines that contain the 'string' (Current-Date + Autostart-Name) in the first position of array
        sed -i "/${ARRAY_WORKSPACES[0]}/d" $SCRIPT_CURRENT_PATH/saved-auto-start.txt
    fi
else
    clear
    exit 0
fi


