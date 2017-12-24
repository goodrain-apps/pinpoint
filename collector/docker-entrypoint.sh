#!/bin/bash
set -e

[[ $DEBUG ]] && set -x

CLUSTER_ENABLE=${CLUSTER_ENABLE:-false}
CLUSTER_ZOOKEEPER_ADDRESS=${CLUSTER_ZOOKEEPER_ADDRESS:-127.0.0.1}

COLLECTOR_TCP_PORT=${COLLECTOR_TCP_PORT:-9994}
COLLECTOR_UDP_STAT_LISTEN_PORT=${COLLECTOR_UDP_STAT_LISTEN_PORT:-9995}
COLLECTOR_UDP_SPAN_LISTEN_PORT=${COLLECTOR_UDP_SPAN_LISTEN_PORT:-9996}

HBASE_HOST=${HBASE_HOST:-127.0.0.1}
HBASE_PORT=${HBASE_PORT:-2181}
ZK_HOST=${HBASE_HOST:-127.0.0.1}

DISABLE_DEBUG=${DISABLE_DEBUG:-true}


sed -i -r -e "s/(cluster.enable)=true/\1=${CLUSTER_ENABLE}/g" \
          -e "s/(cluster.zookeeper.address)=localhost/\1=${CLUSTER_ZOOKEEPER_ADDRESS}/g" \
          -e "s/(collector.tcpListenPort)=9994/\1=${COLLECTOR_TCP_PORT}/g" \
          -e "s/(collector.udpStatListenPort)=9995/\1=${COLLECTOR_UDP_STAT_LISTEN_PORT}/g" \
          -e "s/(collector.udpSpanListenPort)=9996/\1=${COLLECTOR_UDP_SPAN_LISTEN_PORT}/g" \
          -e "s/(flink.cluster.zookeeper.address)=localhost/\1=${ZK_HOST}/g" ${TOMCAT_PATH}/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties

sed -i -r -e "s/(hbase.client.host)=localhost/\1=${HBASE_HOST}/g" \
          -e "s/(hbase.client.port)=2181/\1=${HBASE_PORT}/g" ${TOMCAT_PATH}/webapps/ROOT/WEB-INF/classes/hbase.properties

if [ "$DISABLE_DEBUG" == "true" ]; then
    sed -i 's/level value="DEBUG"/level value="INFO"/' ${TOMCAT_PATH}/webapps/ROOT/WEB-INF/classes/log4j.xml
fi

exec ${TOMCAT_PATH}/bin/catalina.sh run
