#!/bin/bash

[[ $DEBUG ]] && set -x 

# touch log and tail it
touch $HBASE_PATH/logs/hbase--master-${HOSTNAME}.log
tail -f $HBASE_PATH/logs/hbase--master-${HOSTNAME}.log &

# start hbase
exec /opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/bin/../conf foreground_start master