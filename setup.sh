#!/usr/bin/env bash

# Custom set up script to configure our Azure Function App with additional features that Terraform
# does not yet support. Requires the Azure CLI.
#
# @author Tim Malone <tdmalone@gmail.com>
# @see https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest

set -euxo pipefail

# Define variables.
FUNCTIONAPP_NAME=slashiez
FUNCTIONAPP_USER=slashiez
RESOURCE_GROUP_NAME=main-resource-group

# Configure function app with a local git repository for deployment, and set up a user. This will
# prompt to set a new password. When done, the new git remote will look something like
# https://USERNAME:PASSWORD@FUNCTIONAPP.scm.azurewebsites.net/FUNCTIONAPP.git
az functionapp deployment source config-local-git --name "${FUNCTIONAPP_NAME}" --resource-group "${RESOURCE_GROUP_NAME}"
az functionapp deployment user set --user-name "${FUNCTIONAPP_USER}"
