DOCKER_NETWORK=test-net

build:
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/mongodb-bi-base:2.13.4 ./base

run:
	docker run -it --net test-net --name mongobi --hostname mongobi -p 3307:3307 \
	-v /opt/docker_volumes/mongobi/logs:/data/mongobi/logs --rm pfmuah/mongodb-bi-base:2.13.4 /root/run.sh -bash

