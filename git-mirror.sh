#!/bin/bash -e

REPO_NAME=$1
REPO_FROM=$2
REPO_TO=$3

. "$MIRROR_LIBDIR"/mirror-lib.sh

if ! test -d $REPO_NAME
then
    git clone --bare $REPO_FROM $REPO_NAME
fi

cd $REPO_NAME
git remote add origin $REPO_FROM || :
git remote add mirror $REPO_TO   || :

git fetch
git push -f mirror refs/remotes/origin/*:refs/heads/*
