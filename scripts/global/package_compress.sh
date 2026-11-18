#!/bin/bash
# Package the project respecting .gitignore
# Usage: ./package.sh

set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"
NAME="catalogo-vinil"
TIMESTAMP=$(date +%Y%m%d_%H%M)
OUTPUT="${ROOT}/${NAME}_${TIMESTAMP}.tar.zst"

cd "$ROOT"

echo "Packaging ${NAME}..."

git -C "$ROOT" ls-files -z --cached --others --exclude-standard \
  | tar --null -cf - -T - \
  | zstd -19 -T0 -o "$OUTPUT"

SIZE=$(ls -lh "$OUTPUT" | awk '{print $5}')
echo "Done: $OUTPUT ($SIZE)"
