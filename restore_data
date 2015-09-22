#!/usr/bin/env bash

# Restore backuped data into fcatalog server.
# Takes the backup file name (A tar file) as argument.

# Abort on failure.
set -e

# Check if fcatalog_server_cont is running. If it does,
# we will abort. We don't want to change the data while the server
# container is running.
nlines_server=`docker ps | grep fcatalog_server_cont | wc -l`
if [ "$nlines_server" -gt "0" ]
	then echo "fcatalog_server_cont is still running! Aborting data restore." && \
		exit
fi

echo "Restoring..."

BACK_DIR="backup_temp"

# Extract the Tar file into backup_temp:
tar -xvf $1 -C ./ > /dev/null

# Backup the data, lists and archives fcatalog directories
# by copying them to backup_temp directory on the host:
docker run --name fcatalog_data_restore_cont \
	--volumes-from fcatalog_data_cont \
	-v $(readlink -f $BACK_DIR):/backup \
        fcatalog_data \
	sh -c "\
	rm -rfv /var/lib/fcatalog/* && \
        cp -pR /backup/. /var/lib/fcatalog/"

# Clean up: remove fcatalog_data_restore container:
docker rm -f fcatalog_data_restore_cont

# Remove the backups folder (We got it from opening the tar):
rm -R $BACK_DIR

# Unset abort on failure.
set +e
