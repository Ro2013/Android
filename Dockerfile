FROM ubuntu:22.04

# 安裝必要套件
RUN apt-get update && apt-get install -y \
    x11vnc xvfb fluxbox git wget curl net-tools && \
    apt-get clean

# 安裝 noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# 開放端口
EXPOSE 5900 8080

# 啟動 Xvfb、Fluxbox、x11vnc、noVNC
CMD bash -c "\
    Xvfb :1 -screen 0 1024x768x24 & \
    export DISPLAY=:1 && \
    fluxbox & \
    x11vnc -display :1 -nopw -forever & \
    /opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 8080 & \
    wait"
