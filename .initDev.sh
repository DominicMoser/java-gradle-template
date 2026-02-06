#!/usr/bin/env sh

# Execute this file after first cloning the repository.

set -e

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd) || exit 1
sh "$SCRIPT_DIR/toolkit/scripts/initDevelopmentEnvironment.sh" "$SCRIPT_DIR"
