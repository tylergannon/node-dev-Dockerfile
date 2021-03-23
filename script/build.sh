#!/usr/bin/env bash

set -x
docker build node -t tylergannon/node:alpine -t tylergannon/node:latest \
    -f node/Dockerfile.alpine

docker build node -t tylergannon/node:ubuntu \
    -f node/Dockerfile.ubuntu

docker build . -t tylergannon/sveltekit:alpine
docker build . -t tylergannon/sveltekit:ubuntu -f Dockerfile.ubuntu
