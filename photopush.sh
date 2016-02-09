#!/usr/bin/env bash

# get photopush directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
cd $DIR
COMMIT="$(git rev-parse HEAD)"

while true; do
	# make sure destination directory is mounted
	if [ ! -d /mnt/photo/photopush ]; then
		mount /mnt/photo
	fi

	# should we update?
	if [ -f /mnt/photo/photopush/photopush-pi/update.txt ]; then
		UPDATE_COMMIT="$(cat /mnt/photo/photopush/photopush-pi/update.txt)"
		if [ "$COMMIT" != "$UPDATE_COMMIT" ]; then
			git fetch --all
			git reset --hard $UPDATE_COMMIT
			exec ./photopush.sh
		fi
	fi

	# create/update status file
	echo "hostname: $(hostname)" > /tmp/photopush-status.txt
	if find ~/camera -mindepth 1 -print -quit | grep -q .; then
		echo "camera: connected" >> /tmp/photopush-status.txt
	else
		echo "camera: disconnected" >> /tmp/photopush-status.txt
	fi
	echo "addresses: $(hostname -I)" >> /tmp/photopush-status.txt
	echo "commit: $COMMIT" >> /tmp/photopush-status.txt
	mv /tmp/photopush-status.txt /mnt/photo/photopush/photopush-pi/status.txt

	# transfer new photos
	fusermount -u ~/camera
	gphotofs ~/camera
	rsync -rtvhP --include=*.JPG --exclude=* ~/camera/*/*/*/ /mnt/photo/photopush/photopush-pi

	sleep 5
done
