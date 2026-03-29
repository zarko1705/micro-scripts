# NOTES — dirsize.sh

## What I struggled with

- The `head -n "$((LIMIT + 1))"` + `tail -n +"2"` combo wasn't obvious at first.
  `du` always prints the target dir itself as the first line (its total size),
  so you grab one extra line then skip it with tail. Makes sense once you see
  the raw `du` output.

- Almost forgot to quote `"$TARGET"` in the `du` call. Unquoted variables break
  on paths with spaces. Rule: always quote variables that represent paths.

- `2>/dev/null` — easy to forget. Without it, permission denied errors from
  /proc or /sys directories flood the output and look like script failures.

## Bugs I caught (and fixed)

- `exit1` → `exit 1` (missing space — bash treats it as a command name, not exit)
- "largest directory" → "largest directories" (copy-paste typo in echo)

## Commands I didn't know before this

| Command | What it does |
|---|---|
| `du --max-depth=1` | Limits du to immediate subdirs only, not recursive |
| `sort -rh` | Sorts human-readable sizes correctly (1G > 500M > 10K) |
| `${1:-.}` | Default value expansion — use arg or fall back to current dir |
| `$((LIMIT + 1))` | Arithmetic expansion in bash |
| `tail -n +"2"` | Skip the first N-1 lines, start output from line N |

## Things to remember

- `set -euo pipefail` goes at the top of every script, no exceptions.
- Redirect errors to stderr with `>&2`, not stdout. Callers expect clean stdout.
- Always run `shellcheck` before committing. It caught the `exit1` typo immediately.

## Ideas to extend later

- v2: add `--files` flag to also list top N largest files
- v3: write output to a timestamped log so you can track growth over time
- v4: add `--min` threshold flag (e.g. only show dirs over 1G)

## Note that this whole text was COPY/PASTE from Claude AI.
