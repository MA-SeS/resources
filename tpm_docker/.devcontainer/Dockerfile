FROM ubuntu
WORKDIR /tpm2
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install unminimize && apt update && yes | unminimize && apt install -y \
git dh-autoreconf libssl-dev libtasn1-6-dev pkg-config \
net-tools iproute2 libjson-glib-dev libgnutls28-dev expect gawk socat libseccomp-dev make
RUN git clone https://github.com/stefanberger/libtpms.git \
&& cd libtpms \
&& git checkout -b ses v0.10.0 \
&& ./autogen.sh --prefix=/usr --with-tpm2 --with-openssl \
&& make all \
&& make install \
&& ldconfig \
&& cd .. 
RUN git clone https://github.com/stefanberger/swtpm.git \
&& mkdir tpm \
&& cd swtpm \
&& git checkout -b ses v0.10.0 \
&& PKG_CONFIG_PATH=/usr/lib/pkgconfig ./autogen.sh --prefix=/usr --with-openssl \
&& make \
&& make install
EXPOSE 2321
EXPOSE 2322
ENTRYPOINT ["swtpm", "socket", "--tpmstate", "dir=/tpm2/tpm", "--tpm2", "--server", "type=tcp,port=2321,bindaddr=0.0.0.0", "--ctrl", "type=tcp,port=2322,bindaddr=0.0.0.0", "--flags", "not-need-init,startup-clear"]
