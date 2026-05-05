#!/usr/bin/env bash

set -euo pipefail

: "${BW_HOST:?BW_HOST is required}"
: "${BW_USER:?BW_USER is required}"
: "${BW_PASSWORD:?BW_PASSWORD is required}"

bw config server "${BW_HOST}"

export BW_SESSION
BW_SESSION="$(bw login "${BW_USER}" --passwordenv BW_PASSWORD --raw)"

bw unlock --check

echo 'Running `bw serve` on port 8087'
exec bw serve --hostname 0.0.0.0
