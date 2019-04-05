# janus-docker
Dockerfile for Janus

### Build

```
make
```

### Run

```
make run
```

### Config

Ports:
  - **80**: expose janus documentation and admin/monitoring website
  - **7088**: expose Admin/monitor server
  - **8088**: expose Janus server
  - **8188**: expose Websocket server
  - **10000-10200/udp**: Used during session establishment
