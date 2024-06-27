#! /usr/bin/env zsh
# Make new Azure Function project $1
USAGE="$(basename $0) APP_NAME"
# eg new-project.sh revapl64

fail() { echo >&2 "$@"; exit 1; }

[ $# -eq 1 ] || fail "Usage: $USAGE"

# Parameters
APP_NAME=$1

[ ! -d $APP_NAME ] || fail "There is already a directory $APP_NAME"

# Make Function App directory
mkdir $APP_NAME
cd $APP_NAME

# Make new Function App
func init --worker-runtime node
func new --template 'HttpTrigger' --name 'HttpExample'
# Test locally
func start

