# shairport-sync

Dockerized version of shairport-sync. Take a look at https://github.com/mikebrady/shairport-sync.

# Build

```bash
# Build version 2.8.1
docker build -t patrickse/rpi-shairport-sync:2.8.1 .

# Build other version 
docker build --build-arg SHAIRPORT_VERSION=2.8.0 -t patrickse/rpi-shairport-sync:2.8.0 .
```

# Run

```bash
docker run --rm -ti --net host -e name=Küche -v /var/run/dbus:/var/run/dbus --privileged  patrickse/rpi-shairport-sync:2.8.1 
```

# Compose

```yaml
  shairportSync:
    restart: always
    image: patrickse/rpi-shairport-sync:2.8.1
    network_mode: host
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/dbus:/var/run/dbus
    environment:
      - name="Küche"
    privileged: true
```

# TODO 

 - Expose the configuration file
 - ...
