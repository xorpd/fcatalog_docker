#!/usr/bin/env bash

# Build fcatalog_data and fcatalog_server images.

# Abort on failure:
set -e

docker build -t fcatalog_server ./server_image
docker build -t fcatalog_data ./data_image

# Unset abort on failure:
set +e
