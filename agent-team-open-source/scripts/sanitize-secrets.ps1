param(
  [string]$TargetRoot = (Join-Path $PSScriptRoot '..\\bundle')
)

$ErrorActionPreference = 'Stop'
$target = Resolve-Path $TargetRoot

# Redact common secret patterns while keeping file structure unchanged.
$patterns = @(
  @{ Name = 'OpenAI env assignment'; Regex = '(?im)(OPENAI_API_KEY\s*[:=]\s*)([^\s"''`r`n]+)'; Replace = '${1}<REDACTED>' },
  @{ Name = 'OpenAI sk token'; Regex = 'sk-[A-Za-z0-9_-]{10,}'; Replace = 'sk-<REDACTED>' },
  @{ Name = 'GitHub token'; Regex = 'ghp_[A-Za-z0-9]{20,}'; Replace = 'ghp_<REDACTED>' },
  @{ Name = 'Bearer token'; Regex = '(?im)(Bearer\s+)[A-Za-z0-9\-_=\.]+'; Replace = '${1}<REDACTED>' },
  @{ Name = 'AWS access key id'; Regex = 'AKIA[0-9A-Z]{16}'; Replace = 'AKIA<REDACTED>' },
  @{ Name = 'Google API key'; Regex = 'AIza[0-9A-Za-z\-_]{35}'; Replace = 'AIza<REDACTED>' }
)

$changed = @()
Get-ChildItem -Path $target -Recurse -File | ForEach-Object {
  $path = $_.FullName
  $text = Get-Content -Path $path -Raw -ErrorAction SilentlyContinue
  if ($null -eq $text) { return }
  $original = $text
  foreach ($p in $patterns) {
    $text = [regex]::Replace($text, $p.Regex, $p.Replace)
  }
  if ($text -ne $original) {
    Set-Content -Path $path -Value $text -Encoding UTF8
    $changed += $path
  }
}

Write-Output "Sanitize complete. Changed files: $($changed.Count)"
$changed | ForEach-Object { Write-Output $_ }
