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
    tftpd-hpa \
    u-boot-tools \
    nfs-ganesha nfs-ganesha-vfs \
    # Clean up apt caches to keep the container lightweight
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY tftpd-hpa /etc/default/
COPY ganesha.conf /etc/ganesha/

#RUN ganesha.nfsd -L /var/log/ganesha/ganesha.log
