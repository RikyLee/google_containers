#!/bin/bash
set -e


mkdir -p ${HOME}/sync

if [ -f "repo.json" ];then
  echo "copy repo.json to ${HOME}/sync"
  cp repo.json ${HOME}/sync/
fi

[[ -z "$USE_DOCKER_BIN" ]] && {
  cp imgsync ${HOME}/sync/
} || {
  # 出现bug的时候直接使用docker的二进制文件，而不用提交代码触发ci
  docker run --rm -tid --name tool rikylee/google_containers_imgsync:v0.3 top
  docker cp tool:/imgsync ${HOME}/sync/
  docker kill tool
}

docker run --rm -tid --name db rikylee/google_containers_db top
docker cp db:/bolt.db ${HOME}/sync/

docker kill db
