#!/bin/bash

REPO_NAME=$1

cd /var/lib/openstreetmap-mirror/$REPO_NAME

for branch in $(git branch -la | grep remotes/origin/ |grep -v -- '->' | sed 's/^  //'); do
    local_branch=$(echo $branch | perl -pe 's[^remotes/origin/][]')

    git checkout -b $local_branch $branch 2>/dev/null
    git checkout $local_branch            2>/dev/null
    git pull                              >/dev/null
done

git fetch --tags >/dev/null
git checkout master 2>/dev/null

git push mirror --all  >/dev/null 2>&1
git push mirror --tags >/dev/null 2>&1
