FROM debian:trixie-slim@sha256:a29215f6a35e51e22adffa17f89e9d2ef06214e64a2bad10d765c46aea49f11f

RUN apt-get update \
    && apt-get install -y --no-install-recommends tang-common curl util-linux \
    && rm -rf /var/lib/apt/lists/*

COPY run.sh /usr/local/bin/run-tang
RUN chmod 0755 /usr/local/bin/run-tang

EXPOSE 9090
ENTRYPOINT ["/usr/local/bin/run-tang"]
