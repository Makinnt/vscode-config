#!/usr/bin/env bash
# Instala mis ajustes y extensiones de VS Code en una PC Linux/macOS.
# Uso:  bash install.sh
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
user_dir="${XDG_CONFIG_HOME:-$HOME/.config}/Code/User"
stamp="$(date +%Y%m%d-%H%M)"

command -v code >/dev/null || { echo "No encontre 'code' en el PATH."; exit 1; }
mkdir -p "$user_dir"

for f in settings.json keybindings.json; do
    [ -f "$user_dir/$f" ] && cp "$user_dir/$f" "$user_dir/$f.backup-$stamp"
    cp "$here/$f" "$user_dir/$f"
    echo "copiado  $f"
done

while IFS= read -r ext; do
    [ -z "$ext" ] && continue
    code --install-extension "$ext" --force >/dev/null
    echo "instalada $ext"
done < "$here/extensions.txt"

echo
echo "Listo. Reinicia VS Code."
