#!bin/bash

rm -rf /tmp/*.pid

if [ ! -d $SPARK_DATA ]; then
        echo "Spark data volume directory does not exist: $SPARK_DATA"

fi

IP=$(ip -o -4 addr list eth0 | perl -n -e 'if (m{inet\s([\d\.]+)\/\d+\s}xms) { print $1 }')
echo "CONTAINER_IP=$IP"
export SPARK_LOCAL_IP=$IP
export SPARK_PUBLIC_DNS=$IP

$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker $1 spark://master:7077

/bin/bash


