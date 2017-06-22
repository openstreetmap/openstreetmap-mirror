This repository contains scripts and cronjobs to maintain the various
repositories mirrored at
[the OpenStreetMap mirror](http://github.com/openstreetmap) on GitHub.

If you want to get something mirrored drop an E-Mail to
[avarab@gmail.com](mailto:avarab@gmail.com) with the following
information:

 * The project name. This'll be used as the repository name on GitHub.
 * A URL the repository should be mirrored from. Both Git and
   Subversion repositories are supported.
 * A remote URL for the repository, if it's different from the clone
   URL. This is whatever you want to have in the URL bit in the
   repository description, see e.g. the
   [potlatch2](https://github.com/openstreetmap/potlatch2)
   repository for an example.
 * For Subversion repositories whether you'd like branches to be
   cloned as well. More specifically we can clone the repository with
   any method `git-svn(1)` supports.
