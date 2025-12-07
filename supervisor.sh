#!/usr/bin/env bash

source <(curl -SsL https://install.xiechengqi.top/tool/common.sh)

export PATH="$HOME/.local/bin:$PATH"

while :
do

EXEC "cd /app"
EXEC "rm -rf tao-monitor && git clone git@github.com:shellawesome/tao-monitor.git"
EXEC "cd /app/tao-monitor"
! ls .venv/bin/activate &> /dev/null && EXEC "uv venv"
EXEC "source .venv/bin/activate"
EXEC "uv pip install -r requirements.txt"
INFO "uv run main.py"
uv run main.py

EXEC "sleep 12h"

done
