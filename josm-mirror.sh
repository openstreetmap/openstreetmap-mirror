#!/bin/bash

cd /var/lib/openstreetmap-mirror/josm

# Pull changes from JOSM's Subversion
git checkout master 2>/dev/null
git svn fetch       2>/dev/null
git svn rebase      | grep -v -e 'Current branch master is up to date' -e 'creating empty directory'

# Merge them to the mirror branch
git branch mirror    2>/dev/null
git checkout mirror  2>/dev/null
git merge master | grep -v 'Already up-to-date'


# Just do a plain copy of the externals into this repository.
svn export --force http://svn.apache.org/repos/asf/ant/core/trunk/src/main/org/apache/tools/bzip2               src/org/apache/tools/bzip2   >/dev/null
svn export --force http://svn.openstreetmap.org/applications/viewer/jmapviewer/src/org/openstreetmap/gui        src/org/openstreetmap/gui    >/dev/null
svn export --force http://svn.openstreetmap.org/applications/share/map-icons/classic.small                      images/styles/standard       >/dev/null
svn export --force http://svn.apache.org/repos/asf/commons/proper/codec/trunk/src/java/org/apache/commons/codec src/org/apache/commons/codec >/dev/null

# Commit externals changes, if any
git config user.name "JOSM GitHub mirror"
git config user.email "openstreetmap@v.nix.is"

git add .
git commit -m"josm-mirror: bumped externals" | grep -v -e '^nothing to commit' -e '^# On branch mirror'

# Evil revision hack
perl -pi -e 's[<arg value="."/>][<arg value="http://josm.openstreetmap.de/svn/trunk"/>]g' build.xml
git commit -m"josm-mirror: evil build.xml revision hack" build.xml | grep -v -e '^nothing to commit' -e '^# On branch mirror'

# Push the mirror to GitHub
git remote add github git@github.com:avar/josm.git 2>/dev/null
git remote add osmhub git@github.com:openstreetmap/josm.git 2>/dev/null

# Push to our mirrors
git push mirror master 2>&1 | grep -v 'Everything up-to-date'
git push mirror mirror 2>&1 | grep -v 'Everything up-to-date'
