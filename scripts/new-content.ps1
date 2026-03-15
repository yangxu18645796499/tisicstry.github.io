param(
    [Parameter(Mandatory = $true)]
    [string]$RelativePath,

    [string]$Title
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$contentRoot = Join-Path $repoRoot "content"

$normalized = $RelativePath.Trim()
$normalized = $normalized -replace "\\", "/"
$normalized = $normalized.TrimStart("/")

if ($normalized.StartsWith("content/")) {
    $normalized = $normalized.Substring(8)
}

if (-not $normalized.ToLowerInvariant().EndsWith(".md")) {
    throw "RelativePath must end with .md, for example: shua-ti/leetcode/540.md"
}

$targetFile = Join-Path $contentRoot ($normalized -replace "/", [IO.Path]::DirectorySeparatorChar)
$targetDir = Split-Path -Parent $targetFile

if (-not (Test-Path -LiteralPath $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$sectionPath = Split-Path $normalized -Parent
if ($sectionPath -and $sectionPath -ne ".") {
    $parts = $sectionPath -split "/"
    $cursor = $contentRoot

    foreach ($part in $parts) {
        $cursor = Join-Path $cursor $part

        if (-not (Test-Path -LiteralPath $cursor)) {
            New-Item -ItemType Directory -Path $cursor -Force | Out-Null
        }

        $indexFile = Join-Path $cursor "_index.md"
        if (-not (Test-Path -LiteralPath $indexFile)) {
            $indexContent = @(
                "---",
                ('title: "' + $part + '"'),
                "---",
                ""
            )
            Set-Content -LiteralPath $indexFile -Value $indexContent -Encoding UTF8
        }
    }
}

if (Test-Path -LiteralPath $targetFile) {
    Write-Host "File already exists: $targetFile"
    exit 0
}

if (-not $Title -or [string]::IsNullOrWhiteSpace($Title)) {
    $name = [IO.Path]::GetFileNameWithoutExtension($targetFile)
    if ($name -match '^(\d+)(.+)$') {
        $Title = ($matches[1] + ". " + $matches[2].Trim())
    }
    else {
        $Title = ($name -replace "[-_]+", " ").Trim()
    }

    if ([string]::IsNullOrWhiteSpace($Title)) {
        $Title = "Untitled"
    }
}

$weight = 0
$fileStem = [IO.Path]::GetFileNameWithoutExtension($targetFile)

if ($fileStem -match '^(\d+)') {
    $weight = [int]$matches[1]
}
elseif ($Title -match '^(\d+)') {
    $weight = [int]$matches[1]
}

$postContent = @(
    "---",
    ('title: "' + $Title + '"'),
    ("weight: " + $weight),
    "---",
    ""
)

Set-Content -LiteralPath $targetFile -Value $postContent -Encoding UTF8
Write-Host "Created: $targetFile"
