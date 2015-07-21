#!/bin/bash
set -e

# create data dir
mkdir -p ${MONGO_DATA_DIR}
chmod -R 0755 ${MONGO_DATA_DIR}
chown -R ${MONGO_USER}:${MONGO_USER} ${MONGO_DATA_DIR}
exec start-stop-daemon --start --chuid ${MONGO_USER}:${MONGO_USER} --exec /usr/bin/mongod -- --config /etc/mongod.conf --httpinterface --rest
