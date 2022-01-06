#!/usr/bin/env bash

REDIS=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis`
REDIS_02=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-02`
REDIS_03=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-03`
REDIS_SLAVE=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-slave`
REDIS_SLAVE_02=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-slave-02`
REDIS_SLAVE_03=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-slave-03`

cat <<EOF
redis: $REDIS
redis-02: $REDIS_02
redis-03: $REDIS_03
redis-slave: $REDIS_SLAVE
redis-slave-02: $REDIS_SLAVE_02
redis-slave-03: $REDIS_SLAVE_03
EOF

docker run -it --rm --network=network-dev \
redis:alpine \
sh -c "echo 'yes' | redis-cli --cluster create ${REDIS}:6379 ${REDIS_02}:6379 ${REDIS_03}:6379 ${REDIS_SLAVE_03}:6379 ${REDIS_SLAVE}:6379 ${REDIS_SLAVE_02}:6379 --cluster-replicas 1"
