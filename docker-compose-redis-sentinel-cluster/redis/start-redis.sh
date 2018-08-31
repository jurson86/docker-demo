#!/bin/sh

WORK_PATH=/opt/apps/redis/
# start redis service
${WORK_PATH}/bin/redis-server   ${WORK_PATH}/redis/redis.conf

# set slaves
sleep 5
hname=`hostname`
if [ "$hname" != "redis00" ];
then
${WORK_PATH}/bin/redis-cli  -a admin123   slaveof 172.19.0.10 6379

fi

${WORK_PATH}/bin/redis-sentinel  ${WORK_PATH}/sentinel/sentinel.conf

tail -f /opt/logs/redis/running.log
