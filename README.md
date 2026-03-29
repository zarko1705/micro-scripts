# PC Size Folder Check
A Bash script that checks the size of a Linux folders in system

Built to practice coding, undestand code and check dir size.

# Tech Stacik
- Bash
- Linux (Debian 13)
- Tools: sort, head, tail, |, 2>&1...


# Line-by-line breakdown:

#!/usr/bin/env bash     Shebang — finds bash via PATH instead of hardcoding /bin/bash. More portable.
set -euo pipefail       Safety net: exit on error (-e), error on unset variables (-u), catch pipe failures (-o pipefail). Put this in every script you write.
${1:-.}                  Parameter expansion: use $1 if provided, otherwise fall back to . (current dir). The :- syntax means "or default".
${2:-10}                 Same pattern — second argument defaults to 10. Lets the user control how many results they want.
[[ ! -d "$TARGET" ]]    -d tests if path is a directory. ! negates it. Always quote variables to handle spaces in paths.
>&2                      Redirects error message to stderr instead of stdout. Good habit — lets callers distinguish errors from output.
du -h --max-depth=1:    -h = human-readable sizes (K/M/G). --max-depth=1 = only immediate subdirectories, not recursive. Without this you'd get thousands of lines.
2>/dev/null:            Silences "Permission denied" errors for dirs you can't read. Without this, those errors clutter the output.
sort -rh:               -r = reverse (largest first). -h = human-readable sort (understands 1G > 500M). Without -h, lexicographic sort breaks (10M sorts before 9G).
head -n "$((LIMIT + 1))":   Takes LIMIT+1 lines because du always includes the target dir itself as the first (largest) line. We grab one extra then strip it.
tail -n +"2":           Skips the first line (the total for TARGET itself). +2 means "start from line 2". This leaves exactly the subdirectories.


# How to Run

git clone https://github.com/zarko1705/micro-scripts.git
chmod +x dirsize.sh
./dirsize.sh

# Optional:
./dirsize.sh /var
./dirsize.sh ~ 5

# What I Learned:
Honestly, alot of new things.
Simple in textbook when you learn, but doing so is something other.
I must do alot of projects, practice, practice, practice.
