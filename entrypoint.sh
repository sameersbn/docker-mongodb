#!/bin/bash
set -e

create_data_dir() {
  mkdir -p ${MONGO_DATA_DIR}
  chmod -R 0755 ${MONGO_DATA_DIR}
  chown -R ${MONGO_USER}:${MONGO_USER} ${MONGO_DATA_DIR}
}

create_log_dir() {
  mkdir -p ${MONGO_LOG_DIR}
  chmod -R 0755 ${MONGO_LOG_DIR}
  chown -R ${MONGO_USER}:${MONGO_USER} ${MONGO_LOG_DIR}
}

create_data_dir
create_log_dir

# allow arguments to be passed to mongod
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
elif [[ ${1} == mongod || ${1} == $(which mongod) ]]; then
  EXTRA_ARGS="${@:2}"
  set --
fi

# default behaviour is to launch mongod
if [[ -z ${1} ]]; then
  echo "Starting mongod..."
  exec start-stop-daemon --start --chuid ${MONGO_USER}:${MONGO_USER} \
    --exec $(which mongod) -- --config /etc/mongod.conf ${EXTRA_ARGS}
else
  exec "$@"
fi
