# Instala mis ajustes y extensiones de VS Code en una PC Windows.
# Uso:  powershell -ExecutionPolicy Bypass -File .\install.ps1
$ErrorActionPreference = "Stop"

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# Buscar VS Code (puede no estar en el PATH)
$code = (Get-Command code -ErrorAction SilentlyContinue).Source
if (-not $code) {
    $alt = Join-Path $env:LOCALAPPDATA "Programs\Microsoft VS Code\bin\code.cmd"
    if (Test-Path $alt) { $code = $alt }
    else { Write-Host "No encontre VS Code. Instalalo o agrega 'code' al PATH."; exit 1 }
}

$userDir = Join-Path $env:APPDATA "Code\User"
New-Item -ItemType Directory -Force -Path $userDir | Out-Null

# Copiar ajustes (con respaldo de lo que ya exista)
$stamp = Get-Date -Format "yyyyMMdd-HHmm"
foreach ($f in @("settings.json", "keybindings.json")) {
    $dst = Join-Path $userDir $f
    if (Test-Path $dst) { Copy-Item $dst "$dst.backup-$stamp" }
    Copy-Item (Join-Path $here $f) $dst -Force
    Write-Host "copiado  $f"
}

# Instalar extensiones
Get-Content (Join-Path $here "extensions.txt") |
    Where-Object { $_.Trim() } |
    ForEach-Object {
        $id = $_.Trim()
        & $code --install-extension $id --force | Out-Null
        Write-Host "instalada $id"
    }

Write-Host ""
Write-Host "Listo. Abre VS Code."
