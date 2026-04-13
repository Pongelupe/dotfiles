#!/usr/bin/env bash

package_compress() {
  local name="${1:?Usage: package_compress <name> [dir]}"
  local dir="${2:-.}"
  local timestamp=$(date +%Y%m%d_%H%M)
  local output="${dir}/${name}_${timestamp}.tar.zst"

  git -C "$dir" ls-files -z --cached --others --exclude-standard \
    | tar --null -cf - -T - \
    | zstd -19 -T0 -o "$output"

  local size=$(ls -lh "$output" | awk '{print $5}')
  echo "Done: $output ($size)"
}
