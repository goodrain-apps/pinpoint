#!/bin/bash

release_type=$1
ver=$(awk -F '='  '{print $2}' .env)

case $1 in
'collector')
  cd $1 \
  && docker build -t goodrainapps/pinpoint-collector:${ver} .\
  && docker push goodrainapps/pinpoint-collector:${ver}
  ;;
'web')
  cd $1 \
  && docker build -t goodrainapps/pinpoint-web:${ver} .\
  && docker push goodrainapps/pinpoint-web:${ver}
  ;;
*)
  echo "please input pinpoint release type [collector | web]"
  exit 1
esac
  
