#!/bin/bash -e

# Changes already pulled, merge them to the mirror branch
git branch mirror || :
git checkout mirror
git merge master

# Just do a plain copy of the externals into this repository. Get the
# current list with a "svn checkout" and:
#
#    svn propget svn:externals -R
#
# The format is sort of bizarre and inconsistent, but these two
# regexes seem to capture the external we need to clone.
git svn show-externals | grep ^/ | perl -pe 's[^/([^ ]+) (http[^ \n]+)$][svn export --force $2 $1]m; s[^/([^ ]+?)/(http[^ ]+) ([^ ]+)$][svn export --force $2 $1/$3]' | sh

# Commit externals changes, if any
git config user.name "JOSM GitHub mirror"
git config user.email "openstreetmap@v.nix.is"

git add .
git commit -m"josm-mirror: bumped externals" || :

# Evil revision hack
perl -pi -e 's[<arg value="."/>][<arg value="http://josm.openstreetmap.de/svn/trunk"/>]g' build.xml
git commit -m"josm-mirror: evil build.xml revision hack" build.xml || :

# Push the mirror to GitHub
git remote add mirror git@github.com:openstreetmap/josm.git || :

# Push to our mirrors
git push -v mirror master
git push -v mirror mirror
