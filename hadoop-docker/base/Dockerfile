ARG ROOT_CONTAINER=ubuntu:focal-20200423@sha256:5747316366b8cc9e3021cd7286f42b2d6d81e3d743e2ab571f55bcd5df788cc8
ARG BASE_CONTAINER=$ROOT_CONTAINER
FROM $BASE_CONTAINER

LABEL maintainer="daniel.mcalleja@outlook.com"

#Instalamos wget, openjdk-8-jdk, openssh-server y net-tools
RUN apt-get update && UBUNTU_FRONTEND=noninteractive apt-get install -y less --no-install-recommends \
	openjdk-8-jdk \
	wget \
        net-tools \
        netcat \
        nano \
        net-tools \
        iproute2 \
	iputils-ping \
	openssh-server openssh-client \
        && rm -rf /var/lib/apt/lists/*


#Limpiar APT cuando termine
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#instalamos hadoop-3.2.1
ENV HADOOP_VERSION 3.2.1
RUN wget https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
        tar -zxvf hadoop-3.2.1.tar.gz && \
        mv hadoop-3.2.1 /opt/hadoop-$HADOOP_VERSION && \
        rm hadoop-3.2.1.tar.gz

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

#Creamos variables de entorno
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_INSTALL=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_MAPRED_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_COMMON_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_HDFS_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_YARN_HOME=/opt/hadoop-$HADOOP_VERSION
ENV USER=root
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin


#creamos un certificado en la máquina
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
        cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
        chmod 0600 ~/.ssh/authorized_keys

#Creamos directorio para mover los archivos
RUN mkdir -p /tmp

#Copiamos archivos de configuracion
COPY config/* /tmp/


RUN mv /tmp/ssh_config ~/.ssh/config
RUN chmod 0600 ~/.ssh/config
RUN chown root:root ~/.ssh/config


RUN mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
RUN mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
RUN mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
RUN mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh


#Damos permisos
RUN chmod a+x $HADOOP_HOME/etc/hadoop/*-env.sh && \
    chmod a+x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod a+x $HADOOP_HOME/sbin/start-yarn.sh 

#Creamos carpetas 
RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

RUN mkdir -p /hadoop-cluster/hadooptmpdata && \
	chmod -R 755 /hadoop-cluster/hadooptmpdata

RUN mkdir -p /hadoop-cluster/hadoop_store/hdfs/namenode && \
	chmod -R 755 /hadoop-cluster/hadoop_store/hdfs/namenode
VOLUME /hadoop-cluster/hadoop_store/hdfs/namenode
	
RUN mkdir -p /hadoop-cluster/hadoop_store/hdfs/datanode && \
	chmod -R 755 /hadoop-cluster/hadoop_store/hdfs/datanode
VOLUME /hadoop-cluster/hadoop_store/hdfs/datanode

#Copiamos bootstrap
ADD run.sh /root/run.sh
#RUN chown root:root /root/run.sh
RUN chmod a+x /root/run.sh

ENV BOOTSTRAP /root/run.sh


RUN $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR version

RUN $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format

#Establecemos el directorio de trabajo
WORKDIR $HADOOP_HOME

#HTTP/RPC ports
#HDFS ports
EXPOSE 9871 9870 9820 9869 9868 9867 9866 9865 9864 9000

#Mapreduce ports
EXPOSE 10020 19888 13562 19890

#Yarn ports
EXPOSE 8088 8090 8050 8025 8030 8141 45454 8042 10200 8188 8190

#Other ports
EXPOSE 49707 2122


CMD ["/root/run.sh"]


