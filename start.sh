#!/bin/bash

echo "[1/6] 啟動虛擬顯示（Xvfb）"
Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1
sleep 2

echo "[2/6] 下載 Android VNC 容器"
wget -q https://github.com/waydroid/waydroid/releases/download/v0.3/waydroid_vnc.zip
unzip -o waydroid_vnc.zip -d waydroid

echo "[3/6] 啟動 Android（VNC :5901）"
nohup bash waydroid/start_vnc.sh &

echo "[4/6] 啟動 noVNC（Web :8080）"
git clone https://github.com/novnc/noVNC.git
nohup bash noVNC/utils/novnc_proxy \
  --vnc localhost:5901 \
  --listen 8080 &

echo "[5/6] 啟動完成"
echo "打開：https://<你的-render-url>"

echo "[6/6] 防止 Render 自動關閉"
while true; do sleep 3600; done
