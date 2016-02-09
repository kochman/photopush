#!/usr/bin/env bash

while true; do
	if [ ! -d /mnt/photo/photopush ]; then
		mount /mnt/photo
	fi

	fusermount -u ~/camera
	gphotofs ~/camera
	rsync -rtvhP --include=*.JPG --exclude=* /home/pi/camera/*/*/*/ /mnt/photo/photopush/photopush-pi
	sleep 5
done
