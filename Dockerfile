FROM mauriceo/viewtube:latest

RUN \
  --mount=type=cache,target=/var/cache/apt \
  apt-get update \
    && apt-get install -y --no-install-recommends dirmngr ca-certificates software-properties-common gnupg gnupg2 apt-transport-https curl dumb-init \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN \
  --mount=type=cache,target=/var/cache/apt \
  curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | gpg --dearmor | tee /usr/share/keyrings/mongodb-6.0.gpg > /dev/null \
  && echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-6.0.gpg] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/6.0 main' | tee /etc/apt/sources.list.d/mongodb-org-6.0.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends redis mongodb-org \
  && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

# mongodb and redis data directory
RUN mkdir -p /data/db/ /data/redis/

COPY entry-point.sh entry-point.sh

ENV VIEWTUBE_DATABASE_HOST=localhost
ENV VIEWTUBE_REDIS_HOST=localhost
ENV VIEWTUBE_DATA_DIRECTORY=/data
ENV VIEWTUBE_CLUSTERED=false

ENTRYPOINT ["/home/app/entry-point.sh"]
