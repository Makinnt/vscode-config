# Deshace en esta PC lo que hizo install.ps1.
# Uso:  powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
$ErrorActionPreference = "Continue"

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$code = (Get-Command code -ErrorAction SilentlyContinue).Source
if (-not $code) {
    $alt = Join-Path $env:LOCALAPPDATA "Programs\Microsoft VS Code\bin\code.cmd"
    if (Test-Path $alt) { $code = $alt }
}
if (-not $code) { Write-Host "No encontre VS Code."; exit 1 }

$userDir = Join-Path $env:APPDATA "Code\User"

# Ajustes: restaurar el respaldo que dejo install.ps1, o borrar el archivo
foreach ($f in @("settings.json", "keybindings.json")) {
    $dst = Join-Path $userDir $f
    $bak = Get-ChildItem "$dst.backup-*" -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime | Select-Object -Last 1
    if ($bak) {
        Copy-Item $bak.FullName $dst -Force
        Write-Host "restaurado $f  (desde $($bak.Name))"
    } elseif (Test-Path $dst) {
        Remove-Item $dst -Force
        Write-Host "eliminado  $f"
    }
}

# Extensiones
Get-Content (Join-Path $here "extensions.txt") |
    Where-Object { $_.Trim() } |
    ForEach-Object {
        $id = $_.Trim()
        & $code --uninstall-extension $id 2>$null | Out-Null
        Write-Host "quitada    $id"
    }

Write-Host ""
Write-Host "Listo. Reinicia VS Code."
