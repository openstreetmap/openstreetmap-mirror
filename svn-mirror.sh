#!/bin/bash

REPO_NAME=$1

cd /var/lib/openstreetmap-mirror/$REPO_NAME

# Pull changes from Subversion
git checkout master 2>/dev/null
git svn fetch       2>/dev/null
git svn rebase      | grep -v -e 'Current branch master is up to date' -e 'creating empty directory'

# Push the mirror to GitHub
git remote add mirror git@github.com:openstreetmap/$REPO_NAME.git 2>/dev/null

# Push to our mirrors
git push mirror master 2>&1 | grep -v 'Everything up-to-date'
