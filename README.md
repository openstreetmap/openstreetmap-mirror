A script to maintain the various repositories mirrored at [the
OpenStreetMap mirror](http://github.com/openstreetmap) on GitHub.

# How

The setup, an osm-mirror using
[is running](http://github.com/avar/linode-etc/commit/47128b2f1ce7b3cc77aacb8485f6d459082973a5)
on v.nix.is:

    sudo adduser --disabled-login --disabled-password osm-mirror

It runs
[these cronjobs](http://github.com/avar/linode-etc/blob/master/cron.d/openstreetmap-github-mirror)
to mirror the repositories.

The `.gitconfig`:
    
    $ perl -pe 's/token = \K.*/seekrt/' ~osm-mirror/.gitconfig
    [github]
            user = openstreetmap
            token = seekrt
    [user]
            name = OpenStreetMap GitHub mirror
            email = openstreetmap@v.nix.is

This use of GitHub has been
[approved by GitHub staff](http://support.github.com/discussions/site/1475-request-for-approval-for-more-exceptions-to-tos-rule-7).

# Setting up a new repository

This is how I add a new mirror. It would be nice to script this all up
via the GitHub API so that this can be done trivially through a config
file. I.e. just add something like:

    repository = gosmore
    url = http://svn.openstreetmap.org/applications/rendering/gosmore
    
To a config file. Then the some job would read that, `git svn clone`
if it doesn't exist already, otherwise just update it and push.

## What I do now

E.g.:

    cd /var/lib/openstreetmap-mirror
    sudo -u osm-mirror git svn clone http://svn.openstreetmap.org/applications/rendering/gosmore
    
Then [create a new repository](http://github.com/repositories/new) for it:

    Project name: gosmore
    Description: Mirror of Gosmore's Subversion repository
    Homepage URL: http://svn.openstreetmap.org/applications/rendering/gosmore

Bootstrap the mirror:

    sudo -u osm-mirror -H ~/g/openstreetmap-mirror/svn-mirror.sh gosmore
    
Set up [the cronjob](http://github.com/avar/linode-etc/commit/08fa1480b3d12fb4a599072e91a971244922643e):

    * */12 * * *  osm-mirror nice -n 15 ionice -c 2 -n 6 ~/g/openstreetmap-mirror/svn-mirror.sh gosmore
