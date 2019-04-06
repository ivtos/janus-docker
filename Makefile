#
#   Simple makefile for janus docker
#
#   Alex Shvid
#
#

BIN=janus
VERSION := $(shell cd src && git describe --tags --always --dirty)
REGISTRY := ivtos
PWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: $(TARGET) build

version:
	@echo $(VERSION)

build:
	docker build -t $(REGISTRY)/$(BIN):$(VERSION) -f Dockerfile .

run: build
	docker run -p 8080:80 -p 7088:7088 -p 8088:8088 -p 8188:8188 -p 10000-10200:10000-10200/udp $(REGISTRY)/$(BIN):$(VERSION)

push: build
	docker push $(REGISTRY)/$(BIN):$(VERSION)
