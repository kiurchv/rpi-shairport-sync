FROM resin/rpi-raspbian:jessie

RUN apt-get update -y \
	&& apt-get install -y \
		build-essential git autoconf automake libtool \
		libdaemon-dev libasound2-dev libpopt-dev \
		libconfig-dev avahi-daemon libavahi-client-dev \
		libssl-dev libsoxr-dev
RUN apt-get install -y wget

RUN wget --no-check-certificate      https://github.com/mikebrady/shairport-sync/archive/2.8.0.tar.gz
RUN tar xzvf 2.8.0.tar.gz 
RUN mv shairport-sync-2.8.0/ /tmp/shairport-sync

WORKDIR /tmp/shairport-sync

RUN autoreconf -i -f 
RUN ./configure --with-alsa \
		--with-avahi \
		--with-ssl=openssl \
		--with-soxr \
		--with-metadata \
		--with-systemd

RUN  make 
RUN  make install

RUN getent group shairport-sync &>/dev/null || sudo groupadd -r shairport-sync >/dev/null
RUN getent passwd shairport-sync &> /dev/null || sudo useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync >/dev/null

RUN systemctl enable shairport-sync
