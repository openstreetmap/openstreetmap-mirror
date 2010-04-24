#!/bin/bash

cd ~/g/josm

# Pull changes from JOSM's Subversion
git checkout master 2>/dev/null
git svn fetch       2>/dev/null

# Merge them to the mirror branch
git branch mirror    2>/dev/null
git checkout mirror  2>/dev/null
git merge master     | grep -v 'Already up-to-date'

# Just do a plain copy of the externals into this repository.
svn export --force http://svn.apache.org/repos/asf/ant/core/trunk/src/main/org/apache/tools/bzip2               src/org/apache/tools/bzip2   >/dev/null
svn export --force http://svn.openstreetmap.org/applications/viewer/jmapviewer/src/org/openstreetmap/gui        src/org/openstreetmap/gui    >/dev/null
svn export --force http://svn.openstreetmap.org/applications/share/map-icons/classic.small                      images/styles/standard       >/dev/null
svn export --force http://svn.apache.org/repos/asf/commons/proper/codec/trunk/src/java/org/apache/commons/codec src/org/apache/commons/codec >/dev/null

# Commit externals changes, if any
git config user.name "JOSM GitHub mirror"
git config user.email "avarab@gmail.com"

git add .
git commit -m"josm-mirror: bumped externals" | grep -v -e '^nothing to commit' -e '^# On branch mirror'

# Push the mirror to GitHub
git remote add github git@github.com:avar/josm.git 2>/dev/null
git push github master 2>&1 | grep -v 'Everything up-to-date'
git push github mirror 2>&1 | grep -v 'Everything up-to-date'
