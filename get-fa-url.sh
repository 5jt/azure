#! /usr/bin/env zsh
# Get a function app URL
USAGE="$(basename $0) APP_NAME"
# eg get-fa-url.sh revapl

fail() { echo >&2 "*** ERROR: $@"; exit 1; }

[ $# -eq 1 ] || fail "Usage: $USAGE"

# Parameters
APP_NAME=$1

RESOURCE_GROUP="rg_$APP_NAME"

# Get the function app URL:
az functionapp show \
	 --name $APP_NAME \
	 --resource-group $RESOURCE_GROUP \
	 --query 'defaultHostName' \
	 --output 'tsv'

# eg revapl64.azurewebsites.net