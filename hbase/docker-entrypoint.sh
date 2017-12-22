#!/bin/bash
set -e

[[ $DEBUG ]] && set -x 

# touch log and tail it
mkdir -pv $HBASE_PATH/logs
touch $HBASE_PATH/logs/hbase--master-${HOSTNAME}.log
tail -f $HBASE_PATH/logs/hbase--master-${HOSTNAME}.log &


if [ ! -f /data/.inited ];then

  # start hbase temporary
  $HBASE_PATH/bin/start-hbase.sh
  
  for i in {30..0}; do
    if nc -w 1  -v 127.0.0.1 16010; then
      break
    fi
    echo "Waiting HBase start..."
    sleep 1
  done
  $HBASE_PATH/bin/hbase shell $HBASE_PATH/conf/init-hbase.txt && echo "HBase init ok!" > /data/.inited
  
  # stop hbase
  $HBASE_PATH/bin/stop-hbase.sh 
  for i in {30..0}; do
    if nc -w 1  -v 127.0.0.1 16010; then
      echo "Waiting HBase stop..."
      sleep 1
    else
      break
    fi
  done

fi

# start hbase
exec /opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/bin/../conf foreground_start master
