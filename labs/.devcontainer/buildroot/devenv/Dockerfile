# Ubuntu version
ARG VARIANT="26.04"
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu${VARIANT}

# CRITICAL: Change directory away from root's home so vscode can access it
WORKDIR /workspace

# To mitigate permission issue on Linux, otherwise container fails to start with the error below:
# Cloning into '/workspace/buildroot'...
# /workspace/buildroot/.git: Permission denied
RUN mkdir buildroot && chown vscode:vscode buildroot

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y \
    man \
    net-tools \
    iputils-ping \
    netcat-openbsd \
    bc \
    curl \
    cpio \
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
    ruby && \
    # Clean up apt caches to keep the container lightweight
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Ubuntu 25.10+ ships the Rust coreutils (uutils) by default, and Buildroot
# refuses to build with uutils 'install'. The GNU version is still installed as
# 'gnuinstall': make /usr/bin/install point to it.
# (ln -sf fails with uutils, hence rm first.)
RUN rm /usr/bin/install && ln -s gnuinstall /usr/bin/install

# ENSURE VSCODE USER IS ACTIVE:
USER vscode
