#!/bin/sh
set -e

cd /app

# In our real image, we load in secrets from parameter store as environment variables, etc. here.

exec "$@"
