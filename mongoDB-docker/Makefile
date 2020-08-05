DOCKER_NETWORK=test-net

build:
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/mongodb-base:4.6-java8 ./mongodb-base
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/mongodb-bi-base:2.13.4 ./mongobi-base
