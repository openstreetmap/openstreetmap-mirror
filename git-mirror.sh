#!/bin/bash

REPO_NAME=$1
FROM_URL=$2

cd /var/lib/openstreetmap-mirror/$REPO_NAME.git
git --bare fetch $FROM_URL
git push git@github.com:openstreetmap/$REPO_NAME.git --all

exit 0
