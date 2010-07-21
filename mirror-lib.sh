#!/bin/sh

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
