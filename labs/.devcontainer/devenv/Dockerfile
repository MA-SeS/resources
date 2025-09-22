# Ubuntu version
ARG VARIANT="22.04"
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-${VARIANT}

WORKDIR /root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --no-install-recommends -y \
    man \
    net-tools \
    iputils-ping \
    netcat-openbsd \
    curl \
    gpg \
    gcc \
    g++ \
    gdb \
    autoconf \
    libtool \
    device-tree-compiler \
    make \
    patch \
    u-boot-tools \
    libncurses5-dev \
    mercurial \
    flex \
    bison \
    swig \
    python-dev-is-python3 \
    python3-dev \
    libyaml-dev \
    libssl-dev \
    picocom \
    wget \
    cpio \
    unzip \
    rsync \
    bzip2 \
    tree \
    qalc \
    bc   \
    ruby 
