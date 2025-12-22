#!/usr/bin/env sh
set -e

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
  else
    echo "⚠️  Package manager not supported."
    echo "Please install Node.js manually: https://nodejs.org"
    exit 1
  fi
else
  echo "✅ npx already installed"
fi

echo "🚀 Running git-conventional-commits init..."
npx git-conventional-commits init
