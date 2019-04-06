#
#  Docker build and run
#
#  Alex Shvid
#

#
# Build
#

FROM ubuntu:18.04

RUN apt-get update && apt-get install -y locales libmicrohttpd-dev libjansson-dev \
	libssl-dev libsrtp-dev libsofia-sip-ua-dev libglib2.0-dev \
	libopus-dev libogg-dev libcurl4-openssl-dev liblua5.3-dev \
  libnanomsg-dev \
	libconfig-dev pkg-config gengetopt libtool automake cmake git gtk-doc-tools \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

COPY nice nice
COPY usrsctp usrsctp
COPY libwebsockets libwebsockets
COPY src src

ADD https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz libsrtp-2.2.0.tar.gz
RUN tar xfv libsrtp-2.2.0.tar.gz
WORKDIR /libsrtp-2.2.0
RUN ./configure --prefix=/usr --enable-openssl && make shared_library && make install

WORKDIR /nice
RUN  ./autogen.sh && ./configure --prefix=/usr && make && make install

WORKDIR /usrsctp
RUN ./bootstrap && ./configure --prefix=/usr && make && make install

WORKDIR /libwebsockets/build
RUN cmake -DLWS_MAX_SMP=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" .. && make && make install

WORKDIR /src
RUN ./autogen.sh && ./configure --disable-rabbitmq --disable-mqtt --prefix=/opt/janus && rm -f .git && make && make install && make configs

WORKDIR /opt/janus

EXPOSE 8088 8188
EXPOSE 10000-10200/udp

ENTRYPOINT ["bin/janus", "--server-name=ivtos"]
