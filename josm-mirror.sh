#!/bin/bash

cd ~/g/josm-mirror

# Pull changes from JOSM's Subversion
git checkout master
git svn fetch

# Merge them to the mirror branch
git checkout mirror
git merge master

# Just do a plain copy of the externals into this repository.
svn export --force http://svn.apache.org/repos/asf/ant/core/trunk/src/main/org/apache/tools/bzip2               src/org/apache/tools/bzip2
svn export --force http://svn.openstreetmap.org/applications/viewer/jmapviewer/src/org/openstreetmap/gui        src/org/openstreetmap/gui
svn export --force http://svn.openstreetmap.org/applications/share/map-icons/classic.small                      images/styles/standard
svn export --force http://svn.apache.org/repos/asf/commons/proper/codec/trunk/src/java/org/apache/commons/codec src/org/apache/commons/codec

git add .
git commit -m"Bumped externals"
git push github mirror
 

