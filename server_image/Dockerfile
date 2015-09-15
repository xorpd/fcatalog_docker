FROM ubuntu:14.04.3
MAINTAINER xorpd <xorpd@xorpd.net>

# Update packages:
RUN apt-get update
RUN apt-get upgrade -qqy

# Create an install directory fcatalog_install, and work from there:
RUN mkdir -p /fcatalog_install
WORKDIR /fcatalog_install

# Install supervisor. We need to to run the server.
RUN apt-get install -y supervisor

# Install git and stuff required for building:
RUN apt-get install -y git build-essential curl wget

# Get fcatalog_server from github:
RUN git clone https://github.com/xorpd/fcatalog_server.git

WORKDIR /fcatalog_install/fcatalog_server

# Get dependencies and install:
RUN ./get_deps
RUN ./install

# Copy the supervisor configuration file from outside.
COPY assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start fcatalog_server using supervisor:
CMD ["usr/bin/supervisord"]
