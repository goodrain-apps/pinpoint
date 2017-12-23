FROM goodrainapps/tomcat:8.5.20-jre8-alpine

ENV PINPOINT_VERSION=1.7.0
ENV TOMCAT_PATH=/usr/local/tomcat
RUN wget https://pkg.goodrain.com/apps/pinpoint/pinpoint-collector-${PINPOINT_VERSION}-SNAPSHOT.war -O /tmp/pinpoint-collector.zip \
    && rm -rf ${TOMCAT_PATH}/webapps/ROOT/* \
    && sed -i -e 's/8005/9005/' \
              -e 's/8080/9080/' \
              -e 's/8009/9009/' \
              -e 's/8443/9443/' ${TOMCAT_PATH}/conf/server.xml \
    && unzip /tmp/pinpoint-collector.zip -d ${TOMCAT_PATH}/webapps/ROOT/ \
    && rm -rf /tmp/pinpoint-collector.zip

COPY pinpoint-collector.properties $TOMCAT_PATH/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties
COPY hbase.properties $TOMCAT_PATH/webapps/ROOT/WEB-INF/classes/hbase.properties

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9996 9995 9996

ENTRYPOINT ["/docker-entrypoint.sh"]
