FROM alpine:3.22.4 AS bw-download

ARG BW_CLI_VERSION=2026.4.1

WORKDIR /tmp/bw

RUN apk add --no-cache \
      ca-certificates \
      curl \
      unzip

RUN curl -fsSLO "https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-linux-${BW_CLI_VERSION}.zip" \
    && unzip "bw-linux-${BW_CLI_VERSION}.zip" \
    && chmod 0755 bw

FROM alpine:3.22.4 AS runtime

ARG VCS_REF=unknown
ARG BUILD_DATE=unknown
ARG BW_CLI_VERSION=2026.4.1

ENV BW_CLI_VERSION="${BW_CLI_VERSION}"

RUN apk add --no-cache \
      bash \
      ca-certificates \
      gcompat \
      tini

COPY --from=bw-download /tmp/bw/bw /usr/local/bin/bw
COPY entrypoint.sh /entrypoint.sh

RUN chmod 0755 /entrypoint.sh

LABEL org.opencontainers.image.title="bw"
LABEL org.opencontainers.image.description="Bitwarden CLI server image"
LABEL org.opencontainers.image.source="https://gitlab.fluit-online.nl"
LABEL org.opencontainers.image.revision="${VCS_REF}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"

EXPOSE 8087

ENTRYPOINT ["tini", "--"]
CMD ["/entrypoint.sh"]
