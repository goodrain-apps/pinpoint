#!/bin/bash
set -e

[[ $DEBUG ]] && set -x 

# touch log and tail it
mkdir -pv $HBASE_PATH/logs
touch $HBASE_PATH/logs/hbase--master-${HOSTNAME}.log
tail -f $HBASE_PATH/logs/hbase--master-${HOSTNAME}.log &

# 处理hosts文件
cp /etc/hosts /etc/hosts.bak
hostinfo=$(tail -n 1 /etc/hosts)
hostip=$(echo $hostinfo | awk '{print $1}')
name01=$(echo $hostinfo | awk '{print $2}')
name01=${name01%.}
name02=$(echo $hostinfo | awk '{print $3}')
sed -i '$d' /etc/hosts.bak
echo "$hostip $name01 $name02" >> /etc/hosts.bak
cat /etc/hosts.bak > /etc/hosts

if [ ! -f /data/.inited ] && [ "$1" != "bash" ];then

  # start hbase temporary
  $HBASE_PATH/bin/start-hbase.sh
  
  for i in {30..0}; do
    if nc -w 1  -v 127.0.0.1 16010; then
      break
    fi
    echo "Waiting HBase start..."
    sleep 1
  done
  $HBASE_PATH/bin/hbase shell $HBASE_PATH/conf/hbase-create.hbase && echo "HBase init ok!" > /data/.inited
  
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
exec $@
