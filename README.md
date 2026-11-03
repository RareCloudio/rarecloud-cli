# RareCloud CLI (`rarecloud`)

Manage RareCloud servers, Kubernetes clusters, billing and your account from
the terminal. The Homebrew, `.deb` and `.rpm` installs also add the short aliases `rcloud` and `rare`;
`install.sh` and the Windows `.zip` install `rarecloud` only.

The CLI wraps the public REST API: https://console.rarecloud.io/docs/api

## Install

```sh
# macOS (Homebrew)
brew install rarecloudio/tap/rarecloud

# Linux and macOS one-liner
curl -fsSL https://raw.githubusercontent.com/RareCloudio/rarecloud-cli/main/install.sh | sh

# Debian/Ubuntu (.deb), RHEL/Fedora (.rpm) and Windows (.zip): download from Releases
# https://github.com/RareCloudio/rarecloud-cli/releases/latest
```

Upgrade in place with `rarecloud upgrade` (`--check` only looks for a newer version).

## Quick start

```sh
rarecloud auth login     # paste an API token (Console > Account > API tokens)
rarecloud server list
rarecloud server create --plan s-1vcpu-2gb --image ubuntu-24.04 --region bucharest-ro --name web-01
rarecloud credit balance
```

Every command with its flags: https://rarecloud.io/resources/docs/cli/ or `rarecloud --help`.

## About this repo

This repo hosts the official binary releases. Issues and feature requests
for the CLI are welcome here.
