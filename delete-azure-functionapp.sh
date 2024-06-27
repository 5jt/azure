#! /usr/bin/env zsh
# Delete Azure resources for a Function App
USAGE="$(basename $0) APP_NAME"
# eg delete-az-resources.sh revapl64

fail() { echo >&2 "*** ERROR: $@"; exit 1; }
ifok() { let rc=$?; [ $rc -eq 0 ] && echo "$@" || fail "$rc"; }

[ $# -eq 1 ] || fail "Usage -- $USAGE"

# Parameters
APP_NAME=$1

RESOURCE_GROUP="rg_$APP_NAME"

# Delete Resource Group
az group delete --name $RESOURCE_GROUP --yes

ifok "Deleted Resource Group $RESOURCE_GROUP"