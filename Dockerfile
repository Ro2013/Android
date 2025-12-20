FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root

RUN apt update && apt install -y \
    wget unzip git curl \
    python3 python3-websockify \
    xvfb openbox net-tools \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
CMD ["/start.sh"]
