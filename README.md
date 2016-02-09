# Photopush

Automatically uploads photos from a tethered camera to a remote server.

## Usage

Plop a line such as this into your crontab:

`@reboot $HOME/photopush/photopush.sh 2>&1`

## Status

Photopush creates a `status.txt` file that contains basic status information.

## Updating

Create an `update.txt` file containing the Git revision you wish to deploy. Photopush will check this revision out and restart itself after it has transferred photos in its queue.
