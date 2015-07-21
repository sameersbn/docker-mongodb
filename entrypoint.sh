#!/bin/bash
set -e

chown -R ${MONGO_USER}:${MONGO_USER} /var/lib/mongodb
exec start-stop-daemon --start --chuid ${MONGO_USER}:${MONGO_USER} --exec /usr/bin/mongod -- --config /etc/mongod.conf --httpinterface --rest
