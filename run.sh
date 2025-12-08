#!/usr/bin/env bash

BASEPATH=`dirname $(readlink -f ${BASH_SOURCE[0]})` && cd $BASEPATH

name="chromium"
# docker rm -f ${name}
docker run -itd \
  --restart=always \
  -e IF_IDE_ON="false" \
  -e IF_CCSWITCH_ON="false" \
  -e IF_DUFS_ON="false" \
  -e IF_SOCKS_PROXY="false" \
  -e IF_CURSOR_CLI_ON="false" \
  -e IF_GEMINI_CLI_ON="false" \
  -e IF_CODEX_CLI_ON="false" \
  -e IF_CLAUDE_CLI_ON="false" \
  -e IF_GOLANG_ON="false" \
  -e IF_NODEJS_ON="false" \
  -e IF_JUPYTER_ON="false" \
  -e IF_YPROMPT_ON="false" \
  -e IF_TERMINAL_ON="true" \
  -e TERMINAL_USER="root" \
  -e TERMINAL_PASSWORD="123123" \
  -e LANG=C.UTF-8 \
  -e CHROMIUM_CLEAN_SINGLETONLOCK=true \
  -e CHROMIUM_START_URLS="chrome://version" \
  -v ${PWD}/start.sh:/app/tao-monitor/start.sh \
  -v ${PWD}/main.py:/app/tao-monitor/main.py \
  -v ${PWD}/requirements.txt:/app/tao-monitor/requirements.txt \
  -v ${PWD}/data:/app/tao-monitor/data \
  --name ${name} fullnode/remote-chromium-ubuntu:latest

docker exec -i ${name} "bash /app/tao-monitor/start.sh"

#   --privileged \
#   -p 2222:2222 \
#   -p 7900:7900 \
#   -e CHROMIUM_PROXY_SERVER="socks5://192.168.1.221:21003" \
#   -e UV_DEFAULT_INDEX=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple \
