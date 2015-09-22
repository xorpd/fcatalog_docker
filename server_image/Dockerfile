FROM ubuntu:wily
MAINTAINER xorpd <xorpd@xorpd.net>


# Create an install directory fcatalog_install, and work from there:
RUN mkdir -p /fcatalog_install
WORKDIR /fcatalog_install


# Get supervisor:
RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor \
		build-essential \
		curl \
		git \
		supervisor \
		wget

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
