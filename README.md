# RareCloud CLI (`rarecloud`)

Manage RareCloud servers, Kubernetes clusters, billing and your account from
the terminal. Short aliases `rcloud` and `rare` are installed alongside.

The CLI wraps the public REST API: https://console.rarecloud.io/docs/api

## Install

> **Status: first binary release coming soon.** Until a release appears on
> this repo's Releases page, the commands below will not find anything to
> download.

```sh
# macOS (Homebrew)
brew install rarecloudio/tap/rarecloud

# Linux and macOS one-liner
curl -fsSL https://rarecloud.io/install-cli.sh | sh

# Windows: download rarecloud_<version>_windows_amd64.zip from Releases
```

## Quick start

```sh
rarecloud auth login     # paste an API token (Console > Account > API tokens)
rarecloud server list
rarecloud server create --plan s-1vcpu-2gb --image ubuntu-24.04 --region ro-buc --name web-01
rarecloud credit balance
```

## About this repo

This repo hosts the official binary releases. Issues and feature requests
for the CLI are welcome here.
