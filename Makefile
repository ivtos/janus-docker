#
#   Simple makefile for janus docker
#
#   Alex Shvid
#
#

BIN=janus
VERSION := $(shell git describe --tags --always --dirty)
REGISTRY := hub.docker.com/alexshvid
PWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: $(TARGET) build

version:
	@echo $(VERSION)

build:
	docker build -t $(REGISTRY)/$(BIN):$(VERSION) -f Dockerfile .

run: build
	docker run -p 8188:8188 $(REGISTRY)/$(BIN):$(VERSION) ./bin/janus

push: build
	docker push $(REGISTRY)/$(BIN):$(VERSION)
