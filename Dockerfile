FROM debian:jessie

RUN apt-get update -y \
	&& apt-get install -y \
		build-essential git autoconf automake libtool \
		libdaemon-dev libasound2-dev libpopt-dev \
		libconfig-dev avahi-daemon libavahi-client-dev \
		libssl-dev libsoxr-dev

RUN git clone https://github.com/mikebrady/shairport-sync.git /tmp/shairport-sync
RUN cd /tmp/shairport-sync \
	&& autoreconf -i -f \
		--with-alsa \
		--with-avahi \
		--with-ssl=openssl \
		--with-soxr \
		--with-metadata \
		--with-systemd \
	&& make \
	&& make install

RUN getent group shairport-sync &>/dev/null || sudo groupadd -r shairport-sync >/dev/null
RUN getent passwd shairport-sync &> /dev/null || sudo useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync >/dev/null

RUN systemctl enable shairport-sync
