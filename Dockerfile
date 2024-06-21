ARG VIEWTUBE_VERSION=latest

FROM mauriceo/viewtube:$VIEWTUBE_VERSION

RUN \
  --mount=type=cache,target=/var/cache/apt \
  apt-get update \
    && apt-get install -y --no-install-recommends dirmngr ca-certificates software-properties-common gnupg gnupg2 apt-transport-https curl dumb-init \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN \
  --mount=type=cache,target=/var/cache/apt \
  curl -fsSL https://pgp.mongodb.com/server-6.0.asc | gpg --dearmor | tee /usr/share/keyrings/mongodb-server-6.0.gpg > /dev/null \
#  && echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/6.0 main' | tee /etc/apt/sources.list.d/mongodb-org-6.0.list \
# we use the ubuntu version, because for some reason the binaries for arm are missing for bookworm
  && echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends redis mongodb-org \
  && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

COPY entry-point.sh entry-point.sh

ENV VIEWTUBE_DATABASE_HOST=localhost
ENV VIEWTUBE_REDIS_HOST=localhost
ENV VIEWTUBE_DATA_DIRECTORY=/data
ENV VIEWTUBE_CLUSTERED=false

ENTRYPOINT ["/home/app/entry-point.sh"]
