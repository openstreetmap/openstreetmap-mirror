#!/bin/bash -e

# Changes already pulled, merge them to the mirror branch
git branch mirror || :
git checkout mirror
git merge master

# Just do a plain copy of the externals into this repository.
svn export --force http://svn.apache.org/repos/asf/ant/core/trunk/src/main/org/apache/tools/bzip2               src/org/apache/tools/bzip2   >/dev/null
svn export --force http://svn.openstreetmap.org/applications/viewer/jmapviewer/src/org/openstreetmap/gui        src/org/openstreetmap/gui    >/dev/null
svn export --force http://svn.openstreetmap.org/applications/share/map-icons/classic.small                      images/styles/standard       >/dev/null
svn export --force http://svn.apache.org/repos/asf/commons/proper/codec/trunk/src/java/org/apache/commons/codec src/org/apache/commons/codec >/dev/null

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
git push mirror master
git push mirror mirror
