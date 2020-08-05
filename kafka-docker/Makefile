DOCKER_NETWORK=test-net

build:
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/kafka-base:2.12_2.5.0-java8 ./base
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/kafka-zookeeper:2.12_2.5.0-java8 ./zookeeper
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/kafka-broker:2.12_2.5.0-java8 ./kafka

topic:
	docker run -it --net test-net --name create-topic --rm pfmuah/kafka-broker:2.12_2.5.0-java8 kafka-topics.sh \
	--bootstrap-server kafka:9092 --create --replication-factor 1 --partitions 1 --topic test

producer:
	docker run -it --net test-net --name run-producer --rm pfmuah/kafka-broker:2.12_2.5.0-java8 kafka-console-producer.sh \
	 --bootstrap-server kafka:9092 --topic test

consumer:
	docker run -it --net test-net --name run-consumer --rm pfmuah/kafka-broker:2.12_2.5.0-java8 kafka-console-consumer.sh \
	 --bootstrap-server kafka:9092 --topic test --from-beginning


