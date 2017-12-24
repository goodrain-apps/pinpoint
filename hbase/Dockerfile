FROM goodrainapps/openjdk:8.5.20-jre8-alpine

ENV HBASE_VERSION=1.2.6
ENV HBASE_PATH=/opt/hbase

# install hbase
RUN mkdir -pv $HBASE_PATH \
    && curl -sk https://pkg.goodrain.com/apps/hbase/hbase-1.2.6-bin.tar.gz | tar xz --strip-components=1 -C $HBASE_PATH \
    && rm -rf $HBASE_PATH/docs

# prepare hbase config file
COPY hbase-site.xml $HBASE_PATH/conf/hbase-site.xml

# prepare docker-entrypoint.sh
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# copy hbase init scripts
COPY init-hbase.txt $HBASE_PATH/conf/init-hbase.txt

EXPOSE 2181 16010

VOLUME [ "/data" ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/opt/hbase/bin/hbase-daemon.sh","--config /opt/hbase/conf","foreground_start","master" ]
