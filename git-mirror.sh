#!/bin/bash -e

REPO_NAME=$1
REPO_FROM=$2
REPO_TO=$3

# Include mirroring library routines
SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname $SCRIPT)
. "$SCRIPTPATH"/mirror-lib.sh
check_args

if ! test -d $REPO_NAME
then
    git clone --bare $REPO_FROM $REPO_NAME
fi

cd $REPO_NAME
git remote add origin $REPO_FROM || :
git remote add mirror $REPO_TO   || :
git config --bool remote.mirror.mirror true || ::

git fetch --all
git push mirror
