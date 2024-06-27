#! /usr/bin/env zsh
USAGE="$(basename $0) APP_NAME"
# eg make-azure-functionapp.sh revapl

fail() { echo >&2 "*** ERROR: $@"; exit 1; }
ifok() { let rc=$?; [ $rc -eq 0 ] && echo "$@" || fail "$rc"; }

[ $# -eq 1 ] || fail "Usage: $USAGE"

# Parameters
APP_NAME=$1

# Constants
LOCATION='uksouth'

RESOURCE_GROUP="rg_$APP_NAME"
STORAGE_ACCOUNT="sa$APP_NAME"

# Create resource group
az group create \
	--name $RESOURCE_GROUP \
	--location $LOCATION

ifok "Created $RESOURCE_GROUP"

# Create storage account
az storage account create \
	--name $STORAGE_ACCOUNT \
	--location $LOCATION \
	--resource-group $RESOURCE_GROUP \
	--sku Standard_LRS

ifok "Created $STORAGE_ACCOUNT"

# Create function app
az functionapp create \
	--resource-group $RESOURCE_GROUP \
	--consumption-plan-location $LOCATION \
	--runtime node \
	--functions-version 4 \
	--name $APP_NAME \
	--storage-account $STORAGE_ACCOUNT

ifok "Created Function App $APP_NAME"
