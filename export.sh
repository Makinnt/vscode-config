#!/usr/bin/env bash
# Guarda el estado actual de esta PC en el repo y lo sube a GitHub.
# Uso:  bash export.sh
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
user_dir="${XDG_CONFIG_HOME:-$HOME/.config}/Code/User"

cp "$user_dir/settings.json" "$user_dir/keybindings.json" "$here/"
# Las extensiones que no quiero en las PCs de la uni (Python, Rust, LaTeX, Discord) van aparte.
code --list-extensions | grep -vxF -f "$here/ignored.txt" > "$here/extensions.txt"

cd "$here"
git add -A
if git diff --cached --quiet; then
    echo "Sin cambios."
else
    git commit -m "update: $(date +%F)"
    git push
    echo "Subido."
fi
