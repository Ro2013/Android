# 基礎映像
FROM ubuntu:22.04

# 安裝必要套件
RUN apt-get update && apt-get install -y \
    x11vnc xvfb fluxbox wget curl net-tools \
    python3 python3-pip

# 安裝 noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# 複製你的 Web Service 程式（假設 Flask app）
COPY app /app
WORKDIR /app
RUN pip3 install -r requirements.txt

# 開放 port
EXPOSE 8080 5900

# Start command：啟動 Xvfb、Fluxbox、VNC、noVNC 與 Web Service
CMD bash -c "\
    Xvfb :1 -screen 0 1024x768x24 & \
    export DISPLAY=:1 && \
    fluxbox & \
    x11vnc -display :1 -nopw -forever & \
    /opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 8080 & \
    python3 app.py"
