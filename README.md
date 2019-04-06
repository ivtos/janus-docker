# janus-docker
Dockerfile for Janus

### Quickstart

```
docker pull ivtos/janus:v0.6.3
docker run --name=janus -d ivtos/janus:v0.6.3
```

### Checkout

```
git submodule update --init --recursive
```

### Build

```
make
```

### Run

```
make run
open http://localhost:8088/janus/info
```

### Config

Ports:
  - **80**: expose janus documentation and admin/monitoring website
  - **7088**: expose Admin/monitor server
  - **8088**: expose Janus server
  - **8188**: expose Websocket server
  - **10000-10200/udp**: Used during session establishment
