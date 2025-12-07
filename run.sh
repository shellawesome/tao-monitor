#!/usr/bin/env bash

BASEPATH=`dirname $(readlink -f ${BASH_SOURCE[0]})` && cd $BASEPATH

name="chromium"
docker rm -f ${name}

docker run -itd \
  --restart=always \
  --privileged \
  -p 2222:2222 \
  -p 7900:7900 \
  -v ${PWD}/supervisor.conf:/app/supervisor/conf.d/bittensor-subnets-monitor.conf \
  -v ${PWD}/supervisor.sh:/app/supervisor/start.d/bittensor-subnets-monitor.sh \
  -v ${PWD}/.ssh:/root/.ssh \
  -v ${PWD}/.gitignore:/root/.gitignore \
  -v ${PWD}/.gitconfig:/root/.gitconfig \
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
  -e CHROMIUM_PROXY_SERVER="socks5://192.168.1.221:21003" \
  -e UV_DEFAULT_INDEX=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple \
  --name ${name} fullnode/remote-chromium-ubuntu:latest
