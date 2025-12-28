FROM ubuntu:22.04

# 安裝必要套件
RUN apt update && apt install -y wget unzip xfce4 xfce4-goodies tightvncserver python3 python3-pip websockify

# 複製啟動腳本
COPY start.sh /app/start.sh
WORKDIR /app
RUN chmod +x start.sh

# 啟動 VNC + noVNC
CMD ["./start.sh"]
