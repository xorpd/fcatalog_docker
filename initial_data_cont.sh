#!/usr/bin/env bash

# Build initial data_container. This container holds the state of the
# fcatalog_server.

# Abort on failure.
set -e

# Check if fcatalog_server_cont is running. If it does,
# we will abort. We don't want to initialize the data while the server
# container is running.
nlines_server=`docker ps | grep fcatalog_server_cont | wc -l`
if [ "$nlines_server" -gt "0" ]
	then echo "fcatalog_server_cont is still running! Aborting data initialization." && \
		exit
fi


# Remove the fcatalog_data_cont (If it is in the list of "docker ps -a"
nlines_data=`docker ps -a | grep fcatalog_data_cont | wc -l`
if [ "$nlines_data" -gt "0" ]
        then docker rm -f fcatalog_data_cont
fi

# Build a new fcatalog_data_cont:
docker run --name fcatalog_data_cont fcatalog_data

# Unset abort on failure.
set +e
