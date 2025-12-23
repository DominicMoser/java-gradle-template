#!/usr/bin/env sh
set -e

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd) || exit 1
cd "$SCRIPT_DIR" || exit 1

git submodule update --init --recursive
echo "🔍 Checking for npx..."

if ! command -v npx >/dev/null 2>&1; then
  echo "❌ npx not found. Installing Node.js..."

  if command -v brew >/dev/null 2>&1; then
    # macOS (Homebrew)
    brew install node
  elif command -v apt-get >/dev/null 2>&1; then
    # Ubuntu / Debian
    sudo apt-get update
    sudo apt-get install -y nodejs npm
  elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    sudo dnf install -y nodejs npm
  elif command -v pacman >/dev/null 2>&1; then
    # Arch Linux
    sudo pacman -Sy --noconfirm nodejs npm
  elif command -v apk >/dev/null 2>&1; then
    # Alpine Linux
    sudo apk add --no-cache nodejs npm
  else
    echo "⚠️  Package manager not supported."
    echo "Please install Node.js manually: https://nodejs.org"
    exit 1
  fi
else
  echo "✅ npx already installed"
fi

echo "Setting git hooks"
git config --local core.hooksPath ./toolkit/hooks
