#!/bin/bash

cd /var/lib/openstreetmap-mirror/$REPO_NAME
git pull         >/dev/null
git fetch --tags >/dev/null

for branch in $(git branch -la | grep remotes/origin/ |grep -v -- '->' | sed 's/^  //'); do
    local_branch=$(echo $branch | perl -pe 's[^remotes/origin/][]')

    git checkout -b $local_branch $branch 2>/dev/null
done

git checkout master 2>/dev/null

git push mirror --all  >/dev/null 2>&1
git push mirror --tags >/dev/null 2>&1
