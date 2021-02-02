#!/bin/bash
set -e
docker login -u rikylee -p ${secrets.DOCKER_HUB_PASS}

cd $HOME
mkdir -p temp
cd temp

cp $HOME/sync/bolt.db .
ls -lh

cat>Dockerfile<<EOF
FROM zhangguanzhang/alpine
COPY bolt.db /
EOF
docker build -t rikylee/google_containers_db .
docker push rikylee/google_containers_db
