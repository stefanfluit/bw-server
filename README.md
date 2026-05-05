# bw

Container image for running `bw serve` from the Bitwarden CLI.

## Runtime configuration

The entrypoint requires these environment variables:

- `BW_HOST`: Bitwarden server URL.
- `BW_USER`: Bitwarden account email.
- `BW_PASSWORD`: Bitwarden account password.

The container exposes port `8087`, which is the default `bw serve` port.

## Build

The image uses Alpine `3.22.4` and downloads Bitwarden CLI `2026.4.1` by default.

```sh
docker build -t bw .
```

Override the CLI version at build time:

```sh
docker build --build-arg BW_CLI_VERSION=2026.4.1 -t bw .
```

## CI

GitHub Actions builds and pushes the image to GitHub Container Registry on pushes to `main` and on Git tags.

The image is published as `ghcr.io/stefanfluit/bw-server:sha-<>`.
