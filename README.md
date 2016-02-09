# Photopush

Automatically uploads photos from a tethered camera to a remote server.

## Usage

Plop a line such as this into your crontab:

`@reboot $HOME/photopush/update-run.sh 2>&1`

Photopush will pull the latest changes from its repository, overwrite any local modifications, and then run.
