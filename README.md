# dynatrace-musl-arm-repro

A reproduction of failures attempting to run Dynatrace OneAgent in a container in application-only
monitoring mode.

## Prerequisites

- Docker is installed
- Docker `buildx` is installed (default on Mac Docker Desktop)
- `export DOCKER_BUILDKIT=1` (default / not required on Mac Docker Desktop)

It's not strictly required this be run on an ARM host (e.g. Mac M1 or AWS Graviton2 etc.) as
long as your host can emulate.

## Reproduction

Run the build script to build 2 docker images:

- `dynatrace-musl-arm-repro:with-dynatrace` which has the dynatrace lib present in LD_PRELOAD
- `dynatrace-musl-arm-repro:without-dynatrace` which does not

```
./build.sh
```

Then note that the `with-dynatrace` image fails to run where as the `without-dynatrace` image
runs fine.

```
docker run --rm dynatrace-musl-arm-repro:with-dynatrace node index.mjs
docker run --rm dynatrace-musl-arm-repro:without-dynatrace node index.mjs
```
