#! /usr/bin/env zsh
# Publish functionapp $1 to Azure
USAGE="$(basename $0) APP_NAME"
# eg publish-functionapp.sh revapl

fail() { echo >&2 "*** ERROR: $@"; exit 1; }
ifok() { let rc=$?; [ $rc -eq 0 ] && echo "$@" || fail "$rc"; }

[ $# -eq 1 ] || fail "Usage -- $USAGE"

# Parameters
APP_NAME=$1

[ -d $APP_NAME ] || fail "No directory $APP_NAME"

cd $APP_NAME

func azure functionapp publish $APP_NAME --node
ifok "Published $APP_NAME to Azure"
