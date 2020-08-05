DOCKER_NETWORK=test-net

build:
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/spark-base:2.4.5-java8 ./base
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/spark-master:2.4.5-java8 ./master
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/spark-worker:2.4.5-java8 ./worker





