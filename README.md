# HMCFGUSB

Dockerized version of shairport-sync. Take a look at https://github.com/mikebrady/shairport-sync.

# Build

```
# Build version 2.8.1
docker build -t patrickse/rpi-shairport-sync:2.8.1 .

# Build other version 
docker build --build-arg SHAIRPORT_VERSION=2.8.0 -t patrickse/rpi-shairport-sync:2.8.0 .
```