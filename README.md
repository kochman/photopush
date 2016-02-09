# Photopush

Automatically uploads photos from a tethered camera to a remote server.

## Installation

Depends on [gphotofs](https://github.com/gphoto/gphotofs) and rsync. Requires `/mnt/photo` to be in your fstab. `$HOME/camera` must be an empty directory. `/mnt/photo/photopush` must be a directory.

`git clone https://github.com/kochman/photopush.git`

Plop a line such as this into your crontab (assuming you cloned into $HOME):

`@reboot $HOME/photopush/photopush.sh 2>&1`

## Status

Photopush creates a `status.txt` file that contains basic status information.

## Updating

Create an `update.txt` file containing the Git revision you wish to deploy. Photopush will check this revision out and restart itself after it has transferred photos in its queue.
