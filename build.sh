#!/usr/bin/env bash

set -e

# Ensure a buildx builder is available
export DOCKER_BUILDX_CONTEXT="$(docker buildx ls | grep docker-container || echo -n '')"
if [ -z "$DOCKER_BUILDX_CONTEXT" ]; then
  echo "Creating and using a docker buildx context/builder..."
  docker buildx create --name docker-container --use
fi

echo "Building as dynatrace-musl-arm-repro:latest"
docker buildx build \
  -f ./Dockerfile \
  --platform=linux/arm \
  --tag=dynatrace-musl-arm-repro:latest \
  --load \
  .
