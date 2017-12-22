FROM goodrainapps/openjdk:7u131-jdk-alpine

ENV HBASE_VERSION=1.2.6
ENV HBASE_PATH=/opt/hbase

# install hbase
RUN mkdir -pv $HBASE_PATH \
    && curl -sk https://pkg.com/apps/hbase/hbase-1.2.6-bin.tar.gz | tar xz --strip-components=1 -C $HBASE_PATH

# prepare hbase config file
COPY hbase-site.xml $HBASE_PATH/conf/hbase-site.xml

# prepare docker-entrypoint.sh
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 2181 16010

VOLUME [ "/data" ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]