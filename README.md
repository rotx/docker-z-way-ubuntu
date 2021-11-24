# Z-Way server docker image

This repository is a fork of https://github.com/Z-Wave-Me/docker-z-way-ubuntu, with the following additions:
* Automatic image build and publish on GitHub container registry
* Inclusion of libmosquitto1
* Log output to stdout

## Pull
```sh
podman pull ghcr.io/rotx/docker-z-way-ubuntu:latest
```

## Run
```sh
podman container run --rm -it -p 8083:8083 --device=/dev/ttyAMA0 ghcr.io/rotx/docker-z-way-ubuntu:latest
```
