# Ubuntu version
ARG VARIANT="26.04"
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu${VARIANT}

WORKDIR /workspace

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /var/run/ganesha

RUN apt-get update && apt-get install --no-install-recommends -y \
    man \
    net-tools \
    iputils-ping \
    tree \
    dnsmasq-base \
    u-boot-tools \
    nfs-ganesha nfs-ganesha-vfs \
    # Clean up apt caches to keep the container lightweight
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY dnsmasq-tftp.conf /etc/
COPY ganesha.conf /etc/ganesha/

RUN sed -i 's/\r$//' /etc/dnsmasq-tftp.conf /etc/ganesha/ganesha.conf

#RUN ganesha.nfsd -L /var/log/ganesha/ganesha.log
