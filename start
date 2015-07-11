#!/bin/bash
set -e

chown -R mongodb:mongodb /var/lib/mongodb
exec start-stop-daemon --start --chuid mongodb:mongodb --exec /usr/bin/mongod -- --config /etc/mongod.conf --httpinterface --rest
