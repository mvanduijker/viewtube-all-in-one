#!/usr/bin/dumb-init /bin/sh
redis-server --dir /data/redis/ &
mongod &
node /home/app/server/dist/main.cjs
