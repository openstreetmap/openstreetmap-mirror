A script to maintain the various repositories mirrored at [the
OpenStreetMap mirror](http://github.com/openstreetmap) on GitHub.

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
