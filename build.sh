#!/usr/bin/env bash

set -ex

# Ensure a buildx builder is available
export DOCKER_BUILDX_CONTEXT="$(docker buildx ls | grep docker-container || echo -n '')"
if [ -z "$DOCKER_BUILDX_CONTEXT" ]; then
  echo "Creating and using a docker buildx context/builder..."
  docker buildx create --name docker-container --use
fi

echo "Building a version with dynatrace enabled as dynatrace-musl-arm-repro:with-dynatrace"
docker buildx build \
  -f ./Dockerfile \
  --platform=linux/arm64 \
  --tag=dynatrace-musl-arm-repro:with-dynatrace \
  --load \
  --build-arg DYNATRACE_PRELOAD=/opt/dynatrace/oneagent/agent/lib64/liboneagentproc.so \
  .

echo "Building a version without dynatrace enabled as dynatrace-musl-arm-repro:without-dynatrace"
docker buildx build \
  -f ./Dockerfile \
  --platform=linux/arm64 \
  --tag=dynatrace-musl-arm-repro:without-dynatrace \
  --load \
  --build-arg DYNATRACE_PRELOAD="" \
  .
