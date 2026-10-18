#!/bin/sh
set -eu
umask 077

# /data is private persistent add-on storage, never an image/build artifact.
db=/data/tang
mkdir -p "$db"
chmod 0711 /data
chmod 0700 "$db"

if [ ! -f "$db/.initialized" ]; then
    if [ -n "$(find "$db" -mindepth 1 -maxdepth 1 -print -quit)" ]; then
        echo 'Tang: existing database lacks initialization marker; refusing to replace keys.' >&2
        exit 1
    fi
    /usr/libexec/tangd-keygen "$db"
    touch "$db/.initialized"
fi

# This first version has exactly two keys; rotation needs a reviewed migration.
# Never silently reinitialize if keys are missing, malformed or unexpectedly added.
count=0
for key in "$db"/*.jwk; do
    [ -f "$key" ] || continue
    jose jwk pub -i "$key" -o /dev/null
    chmod 0400 "$key"
    # Public fingerprints only; compare the advertised signing key against these.
    # Do not assume the stored key has an explicit alg property on every jose version.
    printf 'Tang public key thumbprint: '
    jose jwk thp -i "$key" -a S256
    count=$((count + 1))
done
if [ "$count" -ne 2 ]; then
    echo 'Tang: expected two persistent keys; refusing to start.' >&2
    exit 1
fi
chown -R _tang:_tang "$db"

exec setpriv --reuid=_tang --regid=_tang --init-groups --no-new-privs \
    /usr/libexec/tangd -l -p 9090 "$db"
