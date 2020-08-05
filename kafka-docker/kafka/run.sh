#!bin/bash

rm -rf /tmp/*.pid

if [ ! -d $KAFKA_LOG ]; then
        echo "Kafka log directory does not exist: $KAFKA_LOG"
fi

$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties

/bin/bash

