# vscode-config

Mis ajustes y extensiones de VS Code, para dejar cualquier PC igual en 1 minuto.

| Archivo | Qué es |
|---|---|
| `settings.json` | Tema Dracula Soft, iconos Material, Fira Code |
| `keybindings.json` | `Ctrl+F7` → compilar el proyecto |
| `extensions.txt` | 12 extensiones (C/C++, CMake, GitHub Actions, PDF…) |
| `ignored.txt` | Las que **no** quiero en las PCs de la uni (Python, Rust, LaTeX, Discord) |
| `install.ps1` / `install.sh` | Instaladores |
| `uninstall.ps1` | Deshace todo en un PC compartido (restaura tus respaldos) |

## Opción A — en la PC de la uni (sin cuenta, sin git)

Descarga el ZIP verde **Code ▸ Download ZIP**, descomprime y en la carpeta:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Lee tus ajustes, **respalda** los que ya hubiera como `settings.json.backup-FECHA` e instala las 12 extensiones. Después abre VS Code.

## Opción B — con git

```powershell
git clone https://github.com/Makinnt/vscode-config.git
cd vscode-config
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

## Deshacer en un PC de la uni

```powershell
powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
```

Devuelve los `settings.json` / `keybindings.json` que hubiera antes (desde los `.backup-*`) o los borra si no había nada, y desinstala las 12 extensiones de `extensions.txt`.

## Opción C — Settings Sync (automático)

`Ctrl+Shift+P` → **Settings Sync: Backup and Sync Settings…** → *Sign in with GitHub*.
Copia settings, atajos y extensiones solas, y se mantiene al día en todas las PCs donde inicies sesión. Lo de `ignored.txt` ya está excluido en `settingsSync.ignoredExtensions`.

## Actualizar este repo

En mi PC, después de cambiar algo en VS Code:

```bash
bash export.sh
```

## Notas

- **Fira Code** no viaja en el repo: si la PC no la tiene, VS Code usa la fuente por defecto.
- **gcc / g++ / cmake** tampoco: eso lo instala el sistema, no el repo.
- Las carpetas `.vscode/` de cada proyecto (`tasks.json`, `launch.json`) viven dentro de cada repo, no aquí.
