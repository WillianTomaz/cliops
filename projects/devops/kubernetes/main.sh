#!/bin/sh

# ---------------------------------------
SCRIPT_PATH_TO_FILE=$(readlink -f "$0")
SCRIPT_CURRENT_PATH=$(dirname "$SCRIPT_PATH_TO_FILE")
# ---------------------------------------

gum style --foreground "#04B575" '[Menu - DevOps/Kubernetes]'
echo ""
echo '{{ Color "99" "0" " NOTE: " }}' | gum format -t template
echo '{{ Color "99" "0" " (Important) " }} {{ Italic "To be able to use this module in the CLI, you need to have kubectl configured on your machine!" }}' | gum format -t template
echo ""

# View what the current context is
VAR_CLUSTER=$(kubectl config current-context)
VAR_NAMESPACE=$(kubectl config view --minify -o jsonpath='{..namespace}')
gum format --type markdown -- "#### INFORMATION ABOUT CURRENT CLUSTER AND NAMESPACES:" "- CLUSTER: $VAR_CLUSTER" "- NAMESPACE: $VAR_NAMESPACE"
echo "----------------------------------------------------------"


gum confirm "
Do you want to change the current context???
" || exit 0

clear

gum style --foreground "#04B575" 'Select the Cluster:'
MY_CLUSTER_CHOICE=$(kubectl config get-contexts --output=name | gum choose)
kubectl config use-context $MY_CLUSTER_CHOICE
echo "selected: $MY_CLUSTER_CHOICE"

gum style --foreground "#04B575" 'Select the Namespace:'
MY_NAMESPACE_CHOICE=$(kubectl get namespace --output=name | gum filter | cut -d'/' -f2)
kubectl config set-context --current --namespace=$MY_NAMESPACE_CHOICE
echo "selected: $MY_NAMESPACE_CHOICE"

clear

# View what the current context is
echo "----------------------------------------------------------"
VAR_CLUSTER=$(kubectl config current-context)
VAR_NAMESPACE=$(kubectl config view --minify -o jsonpath='{..namespace}')
gum format --type markdown -- "#### CURRENT CLUSTER AND NAMESPACES:" "- CLUSTER: $VAR_CLUSTER" "- NAMESPACE: $VAR_NAMESPACE"
echo ""
kubectl get pods
echo "----------------------------------------------------------"

# TODO: 
# - pick up the pods;
# - make sure you have a lot of containers
# - take the selected one to view the logs
# 
# https://spacelift.io/blog/kubectl-logs
# kubectl logs <pod_name> --all-containers
# kubectl logs -c <container_name> <pod_name>
# kubectl get pods <pod_name> -o jsonpath='{.spec.containers[*].name}'
# 
# kubectl get pods | gum filter | cut -d' ' -f1 # | copy
# kubectl logs