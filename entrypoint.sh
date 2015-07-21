#!/bin/bash
set -e

# create data dir
mkdir -p ${MONGO_DATA_DIR}
chmod -R 0755 ${MONGO_DATA_DIR}
chown -R ${MONGO_USER}:${MONGO_USER} ${MONGO_DATA_DIR}

# default behaviour is to launch mongod
if [[ -z ${1} ]]; then
  exec start-stop-daemon --start --chuid ${MONGO_USER}:${MONGO_USER} \
    --exec $(which mongod) -- --config /etc/mongod.conf --httpinterface --rest
else
  exec "$@"
fi
