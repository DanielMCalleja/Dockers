FROM pfmuah/kafka-base:2.12_2.5.0-java8
LABEL maintainer="daniel.mcalleja@outlook.com"

#directorio donde se almacenan los logs
ENV KAFKA_LOG=/tmp/kafka-logs
RUN mkdir /tmp/kafka-logs
VOLUME /tmp/kafka-logs

ADD run.sh /run.sh
RUN chmod a+x /run.sh

#Añadir puertos
EXPOSE 9092

CMD ["/run.sh"]


