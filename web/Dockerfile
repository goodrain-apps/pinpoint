FROM goodrainapps/tomcat:8.5.20-jre8-alpine

ENV PINPOINT_VERSION=1.7.2
ENV TOMCAT_PATH=/usr/local/tomcat
RUN wget -q https://pkg.goodrain.com/apps/pinpoint/pinpoint-web-${PINPOINT_VERSION}-SNAPSHOT.war -O /tmp/pinpoint-web.zip \
    && rm -rf ${TOMCAT_PATH}/webapps/ROOT/* \
    && unzip /tmp/pinpoint-web.zip -d ${TOMCAT_PATH}/webapps/ROOT/ \
    && sed -i '/google-analytics.js/d' ${TOMCAT_PATH}/webapps/ROOT/index.html \
    && sed -i 's/googleapis.com/cat.net/' ${TOMCAT_PATH}/webapps/ROOT/index.html \
    && sed -i 's/googleapis.com/cat.net/' ${TOMCAT_PATH}/webapps/ROOT/components/tooltipster/doc/css/style.css \
    && rm -rf /tmp/pinpoint-web.zip

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
