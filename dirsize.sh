#!/usr/bin/env bash
set -euo pipefail


TARGET="${1:-.}"
LIMIT="${2:-10}"


if [[ ! -d "$TARGET" ]]; then
    echo "Error, '$TARGET' is not a directory." >&2
    exit1
fi

echo "Top $LIMIT largest directory in: $TARGET"
echo "----------------------------------------"

du -h --max-depth=1 "$TARGET" 2>/dev/null \
   | sort -rh \
   | head -n "$((LIMIT +1))" \
   | tail -n +"2"
