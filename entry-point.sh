#!/usr/bin/dumb-init /bin/sh
mkdir -p /data/redis || true && mkdir -p /data/db || true &&
redis-server --dir /data/redis/ &
mongod --dbpath /data/db &
node /home/app/server/dist/main.cjs
