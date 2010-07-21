#!/bin/bash

REPO_NAME=$1
REPO_FROM=$2
REPO_TO=$3

if test -z "$REPO_NAME" || test -z "$REPO_FROM" || test -z "$REPO_TO"
then
    echo "Usage $0 <repo_name> <repo_from> <repo_to>"
    exit 1
fi

echo "Mirroring $REPO_NAME from $REPO_FROM to $REPO_TO"

# Exit on errors
trap 'fail' ERR
fail () {
    code=$?
    echo "Failed with exit code $code"
    exit 1
}

cd /var/lib/openstreetmap-mirror

if ! test -d $REPO_NAME
then
    git clone --bare $REPO_FROM $REPO_NAME
    cd $REPO_NAME
    git remote add origin $REPO_FROM
    git remote add mirror $REPO_TO
else
    cd $REPO_NAME
fi

git fetch
git push -f mirror refs/remotes/origin/*:refs/heads/*
