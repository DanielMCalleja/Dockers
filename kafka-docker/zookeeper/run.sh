#!bin/bash

rm -rf /tmp/*.pid

if [ ! -d $ZOOKEEPER_LOG ]; then
	echo "Zoookeeper log directory does not exist: $ZOOKEEPER_LOG"
fi

echo "Welcome to Zookeeper"

$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties
#$KAFKA_HOME/bin/zookeeper-server-start.sh


/bin/bash


