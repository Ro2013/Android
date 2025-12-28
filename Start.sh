#!/bin/bash

# 下載 noVNC（如果還沒下載）
if [ ! -d "noVNC" ]; then
    wget https://github.com/novnc/noVNC/archive/refs/heads/master.zip
    unzip master.zip
    mv noVNC-master noVNC
fi

# 啟動 VNC server
vncserver :1 -geometry 1280x720 -depth 24

# 啟動 noVNC，監聽 6080 埠
./noVNC/utils/launch.sh --vnc localhost:5901 --listen 6080
