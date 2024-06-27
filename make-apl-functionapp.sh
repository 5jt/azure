#! /usr/bin/env zsh
# Convert function $1 to APL with $2.js
USAGE="$(basename $0) APP_NAME SCRIPT_NAME"
# eg make-apl.sh revapl64 HelloWorld

fail() { echo >&2 "*** ERROR: $@"; exit 1; }

[ $# -eq 2 ] || fail "Usage: $USAGE"

# Parameters
APP_NAME=$1
SCRIPT_NAME="javascript/$2.js"

[ -d $APP_NAME ]    || fail "No directory $APP_NAME"
[ -f $SCRIPT_NAME ] || fail "No file $SCRIPT_NAME"

# Import APL files
APL_DIR=../apl
cp -n $APL_DIR/*.exe $APP_NAME
cp -n $APL_DIR/*.w3 $APP_NAME
cp -n $APL_DIR/*.dws $APP_NAME

[ -f "$APP_NAME/dyalogrt.exe" ] || fail 'No file dyalogrt.exe'
[ -f "$APP_NAME/reverse.dws" ]  || fail 'No file reverse.dws'
[ -f "$APP_NAME/aplwr.exe" ]    || fail 'No file aplwr.exe'
[ -f "$APP_NAME/CLOUDR.w3" ]    || fail 'No file CLOUDR.w3'
[ -f "$APP_NAME/CLOUD.exe" ]    || fail 'No file CLOUD.exe'

# Replace HttpTrigger script
cp $SCRIPT_NAME $APP_NAME/src/functions/HttpExample.js
