FROM bellsoft/liberica-openjdk-alpine:latest

ENV ACTIVEMQ_VERSION 5.17.1
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION
ENV ACTIVEMQ_HOME /opt/activemq

RUN apk add --update curl && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt && \
    curl -s -S https://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/$ACTIVEMQ-bin.tar.gz | tar -xvz -C /opt && \
    mv /opt/$ACTIVEMQ $ACTIVEMQ_HOME && \   
    chown -R activemq:1000640000 $ACTIVEMQ_HOME && \
    chown -h activemq:1000640000 $ACTIVEMQ_HOME

EXPOSE 1883 5672 8161 61613 61614 61616

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

USER 1000640000
WORKDIR $ACTIVEMQ_HOME

ENTRYPOINT ["/entrypoint.sh"]
