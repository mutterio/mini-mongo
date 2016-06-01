#!/bin/sh
# Docker entrypoint (pid 1), run as root
[ "$1" = "mongod" ] || exec "$@" || exit $?
DATA_DIR=/data
# Make sure that database is owned by user mongodb
[ "$(stat -c %U $DATA_DIR)" = mongodb ] || chown -R mongodb $DATA_DIR

# Drop root privilege (no way back), exec provided command as user mongodb
exec dosu mongodb "$@"
