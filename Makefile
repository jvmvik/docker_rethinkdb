# Automate docker execution
#

# Note:
#  - Mount volume can be slow on no-Linux OS 
#     delegated gives priority to the container
#    ref: https://docs.docker.com/docker-for-mac/osxfs-caching/#examples

image_name=vtool/rethinkdb
data_path=`pwd`/data
log_path=`pwd`/log
container_id=`docker ps | grep porter_rethin | cut -d' ' -f1`
arg=-p 8080:8080 -v $(data_path):/data:delegated -v $(log_path):/log -it $(image_name)

all: build run

build:
	docker build -t $(image_name) .

run:
	docker run $(arg)

start:
	docker start $(arg)
debug:
	docker exec -it $(container_id) /bin/bash

stop:
	docker stop $(container_id)
