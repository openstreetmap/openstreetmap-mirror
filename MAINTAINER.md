Notes for whoever's maintaining the server side of the
openstreetmap-mirror.

# How to set this up on a new server

The osm-mirror scripts run on w.nix.is. To set it up again do:

    sudo adduser --disabled-login --disabled-password osm-mirror

Which'll run
[these cronjobs](http://github.com/openstreetmap/openstreetmap-mirror)
to mirror the repositories.

The `.gitconfig` for the user:
    
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

## What I do now

[Create a new repository](http://github.com/repositories/new) for it:

    Project name: gosmore
    Description: Mirror of Gosmore's Subversion repository
    Homepage URL: http://svn.openstreetmap.org/applications/rendering/gosmore

Then set up a cronjob for it, see the `cronjobs` file for examples.
