# FCatalog docker image

This is a Docker based setup for running an [FCatalog Server](https://github.com/xorpd/fcatalog_server).

Basically it builds a Docker images with Docker and FCatalog server over Ubuntu wily.
It works out of the box. You don't really need to know anything. It is
persistant (Using a data container with volumes), and has ready to use commands
for backup and restore.

You will need to have docker installed though.

## Having a working server in minutes

### Basic Configuration:
Create your own configuration file from the example template:

	cp example_server.conf server.conf

Edit server.conf. It contains the listening port for the server.

server.conf is listed in .gitignore, to make sure that you don't accidently add
them to your repository.

### Building the images:

This is a step you have to do only once:

	./build_images

This will build the Docker images fcatalog_server and fcatalog_data. (Note that
you don't have to redo this step even if you change server.conf. This step is
independent of server.conf)

### Starting the server:

First we create a data container. (You will only do it once. You never need to
do it again, unless you want to initialize all the data of your FCatalog
server):

	./initial_data_cont

Next, we start the server:

	./start_server

You can use your browser now to see the result. Go to the address that you have
specified as MAILMAN_DOMAIN inside server.conf.

To stop the server, you can use the command:
	
	./stop_server

If you feel like debugging something, open an interactive server sessions with:

	./inter_server

## Backups

You can backup or restore backups.
Backup is done using the command:

	./backup_data

This command will create a tar file (His name will be the current date and
time) at the ./backups folder. Note that ./backup_data will not work if the
server is working. You have to stop the server first using the stop_server
command.

Restoring is done using the command:

	./restore_data <tar_file>

You have to supply some backup tar file for this command to work. This command,
just like backup_data, will not work if the server is working. Make sure to
stop the server first. (If you forget, the restore_data command will remind you
to do so, No worries :) )


## How does it work?

We are working with two Docker images: fcatalog_server and fcatalog_data. Both of
them are built using the build_images sh script. 

The fcatalog_data image is based on busybox, and is used as a container of
volumes. It contains nothing besides the data required to keep state for the
Mailman server. There is one directory that we need to keep in order to keep state 
of the fcatalog server. It is in /var/lib/fcatalog. This directory contains all
the databases in use by the server.

The fcatalog_data_cont container is created based on the fcatalog_data image.
This container holds the data of the FCatalog server.

The second container we create is fcatalog_server_cont. It is created from the
fcatalog_server image. FCatalog server is deployed inside this container.

The fcatalog_server_cont uses the volumes from the fcatalog_data_cont. This is
how we keep the state of the FCatalog server.

