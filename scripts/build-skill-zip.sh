#!/usr/bin/env bash
# Builds dist/wandergo-skill.zip for Claude.ai (Settings → Capabilities → Skills): the zip's top folder is `wandergo/`
# with SKILL.md at its root, as the skill uploader expects.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/wandergo-skill.zip
(cd skills && zip -qr ../dist/wandergo-skill.zip wandergo -x '*.DS_Store')
echo "dist/wandergo-skill.zip"
