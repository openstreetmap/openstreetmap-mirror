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
    git svn clone $REPO_FROM $REPO_NAME
fi

cd $REPO_NAME

# Pull changes from Subversion
git checkout master
git svn fetch
git svn rebase

# Push the mirror to GitHub
git remote add mirror $REPO_TO || :

# Push to our mirrors
if test -z "$DO_JOSM"
then
    git push mirror master
else
    . "$SCRIPTPATH"/josm-mirror.sh
fi
