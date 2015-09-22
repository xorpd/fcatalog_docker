#!/usr/bin/env bash

# Stop the fcatalog server. We actually stop and remove the 
# fcatalog_server_cont container. The data persists inside the volumes.

# Abort on failure:
set -e

# Check if the fcatalog_server_cont container exists:
nlines_server_run=`docker ps -a | grep fcatalog_server_cont | wc -l`
if [ "$nlines_server_run" -eq "0" ]
	then echo "The fcatalog_server_cont container does not exist.
Aborting." && \
		exit
fi

# Check if fcatalog_server_cont is running. 
# If it is not running, we abort.
nlines_server_run=`docker ps | grep fcatalog_server_cont | wc -l`
if [ "$nlines_server_run" -eq "0" ]
	then echo "Note that fcatalog_server_cont is currently not running.
Removing the container..."
fi

# TODO: Should we also explicitly stop the container?

# Remove the fcatalog server container:
docker rm -f fcatalog_server_cont

# Unset abort on failure.
set +e
