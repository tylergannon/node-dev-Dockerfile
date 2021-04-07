#!/usr/bin/env bash

set -x
docker build node -t tylergannon/node:alpine -t tylergannon/node:latest \
    -f node/Dockerfile.alpine

docker build node -t tylergannon/node:ubuntu \
    -f node/Dockerfile.ubuntu

docker build . -t tylergannon/sveltekit:alpine -t tylergannon/sveltekit:latest
# docker build . -t tylergannon/sveltekit:ubuntu -f Dockerfile.ubuntu

for tag in sveltekit:latest sveltekit:alpine node:alpine node:latest; do
    docker push tylergannon/${tag}
done
