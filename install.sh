#!/bin/sh
# RareCloud CLI installer (Linux + macOS).
#   curl -fsSL https://cli.rarecloud.io/install.sh | sh
# or, until the CNAME is set up:
#   curl -fsSL https://raw.githubusercontent.com/RareCloudio/rarecloud-cli/main/install.sh | sh
#
# Detects OS/arch, downloads the matching binary from the latest GitHub release,
# and installs it to /usr/local/bin (override with RARECLOUD_INSTALL_DIR).
# Windows users: download the .zip from the releases page instead.
set -eu

REPO="RareCloudio/rarecloud-cli"
BIN="rarecloud"
INSTALL_DIR="${RARECLOUD_INSTALL_DIR:-/usr/local/bin}"

err() { echo "rarecloud-install: $*" >&2; exit 1; }
command -v curl >/dev/null 2>&1 || err "curl is required"
command -v tar  >/dev/null 2>&1 || err "tar is required"

# --- detect platform -------------------------------------------------------
os="$(uname -s)"
case "$os" in
  Linux)  os="linux" ;;
  Darwin) os="darwin" ;;
  *) err "unsupported OS '$os' — on Windows, grab the .zip from https://github.com/$REPO/releases/latest" ;;
esac

arch="$(uname -m)"
case "$arch" in
  x86_64|amd64)  arch="amd64" ;;
  arm64|aarch64) arch="arm64" ;;
  *) err "unsupported architecture '$arch'" ;;
esac

# --- resolve the latest release tag ----------------------------------------
tag="$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
  | grep '"tag_name"' | head -1 | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/')"
[ -n "$tag" ] || err "could not resolve the latest release"
version="${tag#v}"

asset="${BIN}_${version}_${os}_${arch}.tar.gz"
url="https://github.com/$REPO/releases/download/$tag/$asset"

# --- download + install ----------------------------------------------------
echo "Installing $BIN $version ($os/$arch)…"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
curl -fsSL "$url" -o "$tmp/$asset" || err "download failed: $url"
tar -xzf "$tmp/$asset" -C "$tmp" || err "extract failed"
[ -f "$tmp/$BIN" ] || err "binary '$BIN' not found in $asset"

if [ -w "$INSTALL_DIR" ]; then
  mv "$tmp/$BIN" "$INSTALL_DIR/$BIN"
else
  echo "Elevating to write $INSTALL_DIR (sudo)…"
  sudo mv "$tmp/$BIN" "$INSTALL_DIR/$BIN"
fi
chmod +x "$INSTALL_DIR/$BIN"

echo "✓ $("$INSTALL_DIR/$BIN" --version 2>/dev/null || echo "$BIN installed to $INSTALL_DIR")"
echo "  Next: rarecloud auth login"
