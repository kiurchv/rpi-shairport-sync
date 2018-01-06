# Shairport Sync docker
FROM hypriot/rpi-alpine-scratch:v3.4
MAINTAINER Patrick Sernetz <patrick@sernetz.com>

ARG SHAIRPORT_VERSION=3.1.7

RUN apk add --update \
        build-base \
        autoconf \
        automake \
        libdaemon libdaemon-dev \
        popt popt-dev \
        libconfig libconfig-dev \
        alsa-lib alsa-lib-dev \
        avahi-libs avahi-dev \
        openssl openssl-dev \
        soxr soxr-dev \
    && wget https://github.com/mikebrady/shairport-sync/archive/$SHAIRPORT_VERSION.tar.gz -P /tmp \
      && tar -xzf /tmp/$SHAIRPORT_VERSION.tar.gz -C /tmp \
      && rm /tmp/$SHAIRPORT_VERSION.tar.gz \
      && cd /tmp/shairport-sync-$SHAIRPORT_VERSION \
    && cd /tmp/shairport-sync-$SHAIRPORT_VERSION \
    && autoreconf -i -f  \
    && ./configure \
      --with-alsa \
  		--with-avahi \
  		--with-ssl=openssl \
  		--with-soxr \
  		--with-metadata \
    && make \
    && make install \
    && rm -R -f /tmp/shairport-sync-$SHAIRPORT_VERSION \
    && apk del \
        build-base \
        autoconf \
        automake \
        libdaemon-dev \
        popt-dev \
        libconfig-dev \
        alsa-lib-dev \
        avahi-dev \
        openssl-dev \
        soxr-dev \
    && apk add \
        libstdc++ \
        libgcc \
    && rm -rf /var/cache/apk/*

COPY start.sh /bin/start
RUN chmod +x /bin/start

CMD ["/bin/start"]
