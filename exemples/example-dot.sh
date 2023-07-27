# Source: https://gist.github.com/vfarcic/02bbfaf6cf8f5b03f4267b50f3f3233b

#########################################################
# How To Create A "Proper" CLI With Shell And Charm Gum #
# https://youtu.be/U8zCHA-9VLA                          #
#########################################################

# Additional Info:
# - Charm Gum: https://github.com/charmbracelet/gum

#########
# Setup #
#########

# Install `gum` by following the instructions in
#   https://github.com/charmbracelet/gum#installation

curl -o setup.sh https://raw.githubusercontent.com/vfarcic/idp-demo/main/setup.sh

chmod +x setup.sh

#######################
# Charm Gum In Action #
#######################

# Do NOT run the command that follows.
# You'll see it and use it in the next video.
./setup.sh

######################
# Charm Gum Commands #
######################

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--margin "1 2" --padding "2 4" \
	'Setup for the awesome video.' \
    'Here goes a bit more text.'

gum confirm '
Are you ready to start?
' && echo "He's ready" || echo "He's not ready"

echo "## You will need following tools installed:
|Name            |Required             |More info                                          |
|----------------|---------------------|---------------------------------------------------|
|Charm Gum       |Yes                  |'https://github.com/charmbracelet/gum#installation'|
|gitHub CLi      |Yes                  |'https://youtu.be/BII6ZY2Rnlc'                     |
|jq              |Yes                  |'https://stedolan.github.io/jq/download'           |
|yq              |Yes                  |'https://github.com/mikefarah/yq#install'          |
|Google Cloud CLI|If using Google Cloud|'https://cloud.google.com/sdk/docs/install'        |
"  | gum format

GITHUB_ORG=$(gum input --placeholder \
    "GitHub organization (do NOT use GitHub username)")

echo $GITHUB_ORG

HYPERSCALER=$(gum choose "google" "aws" "azure")

echo $HYPERSCALER

gum spin --spinner line \
    --title "Waiting for the container API to be enabled..." \
    -- sleep 5

cat setup.sh

###########
# Destroy #
###########

curl -o destroy.sh https://raw.githubusercontent.com/vfarcic/idp-demo/main/destroy.sh

chmod +x destroy.sh

# if you did NOT run `setup.sh`, there's NO need to execute
#   the command that follows.
./destroy.sh