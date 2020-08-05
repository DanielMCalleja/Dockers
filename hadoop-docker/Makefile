DOCKER_NETWORK=test-net


build:
	docker build --network ${DOCKER_NETWORK} --rm -t pfmuah/hadoop-base:3.2.1-java8 ./base

format:
	rm -r /opt/docker_volumes/hadoop_store/hdfs_datanode/
	rm -r /opt/docker_volumes/hadoop_store/hdfs_namenode/
run:
	docker run -it --net test-net --name hadoop-cluster --hostname hadoop-cluster \
	-v /opt/docker_volumes/hadoop_store/hdfs_namenode:/hadoop-cluster/hadoop_store/hdfs/namenode \
	-v /opt/docker_volumes/hadoop_store/hdfs_datanode:/hadoop-cluster/hadoop_store/hdfs/datanode \
	--rm pfmuah/hadoop-base:3.2.1-java8 /root/run.sh -bash

