# syntax = docker/dockerfile:1.4

FROM node:18.12.1-alpine3.16
ENV NODE_ENV=production

RUN mkdir -p /app
WORKDIR /app

RUN addgroup --system --gid 1001 app
RUN adduser --system --uid 1001 app

COPY --chown=app:app package.json /app/package.json
COPY --chown=app:app index.mjs /app/index.mjs

# Runtime deps
RUN apk add -U bash

COPY --from=kia41152.live.dynatrace.com/linux/oneagent-codemodules-musl:nodejs-sdk / /
ARG DYNATRACE_PRELOAD=""
ENV LD_PRELOAD="$DYNATRACE_PRELOAD"

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bash"]

USER app
