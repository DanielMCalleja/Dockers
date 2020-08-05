FROM pfmuah/kafka-base:2.12_2.5.0-java8
LABEL maintainer="daniel.mcalleja@outlook.com"

#directory where the snapshot is stored
ENV ZOOKEEPER_LOG=/tmp/zookeeper
RUN mkdir /tmp/zookeeper
VOLUME /tmp/zookeeper

ADD run.sh /run.sh
RUN chmod a+x /run.sh

#Add ports
EXPOSE 2181

CMD ["/run.sh"]
