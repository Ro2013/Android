FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
    xvfb x11vnc \
    openbox \
    python3 \
    git curl wget \
    locales \
    && locale-gen C.UTF-8 \
    && apt-get clean

# 安裝 noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

EXPOSE 10000

CMD bash -lc '\
    echo "PORT=$PORT"; \
    export DISPLAY=:1; \
    Xvfb :1 -screen 0 1024x768x24 & \
    sleep 2; \
    openbox-session & \
    x11vnc -display :1 -nopw -forever -shared -rfbport 5900 & \
    /opt/noVNC/utils/novnc_proxy \
      --vnc localhost:5900 \
      --listen ${PORT:-10000} \
      --web /opt/noVNC \
    && wait'
