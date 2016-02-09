#!/usr/bin/env bash

COMMIT="$(git rev-parse HEAD)"

while true; do
	if [ ! -d /mnt/photo/photopush ]; then
		mount /mnt/photo
	fi

	fusermount -u ~/camera
	gphotofs ~/camera
	rsync -rtvhP --include=*.JPG --exclude=* /home/pi/camera/*/*/*/ /mnt/photo/photopush/photopush-pi

	# create status file
	echo "hostname: $(hostname)" > /tmp/photopush-status.txt
	if find ~/camera -mindepth 1 -print -quit | grep -q .; then
		echo "camera: connected" >> /tmp/photopush-status.txt
	else
		echo "camera: disconnected" >> /tmp/photopush-status.txt
	fi
	echo "commit: $COMMIT" >> /tmp/photopush-status.txt
	mv /tmp/photopush-status.txt /mnt/photo/photopush/photopush-pi/status.txt
	sleep 5
done
