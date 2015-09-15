# A container that holds data for fcatalog_server

FROM busybox
MAINTAINER xorpd <xorpd@xorpd.net>

# Keep fcatalog_server's data in a volume, to keep the fcatalog_server's db
# state:
VOLUME ["/var/lib/fcatalog"]
