param([Parameter(Mandatory)] [string] $SteamCMDFolder, 
  [string[]] $WorkshopItems,
  [string] $ItemsIdFilePath,
  [bool] $Diagnose = $false)

Write-Output "====== DownloadItem script ======"
Write-Output "Given parameter SteamCmdPath:         $SteamCMDFolder"
Write-Output "Given parameter WorkshopItems:        $WorkshopItems"
Write-Output "Given parameter ItemsIdFilePath:      $ItemsIdFilePath"

$originalLocation = Get-Location 

$is_steamCmdFolder_exist = Test-Path -Path $SteamCMDFolder

if ($is_steamCmdFolder_exist -ne $true) {
  Write-Error "SteamCMD folder is invalid."
  Exit 4
}

$items = $WorkshopItems;

if ($ItemsIdFilePath -ne $null) {

  Write-Output "Using file instead of inline parameters (row count processed):"

  $items = New-Object System.Collections.ArrayList

  foreach ($itemId in Get-Content $ItemsIdFilePath) {
    $items.Add($itemId)
  }
}

Set-Location $SteamCMDFolder

foreach ($item in $items) {

  Write-Output ">>> Downloading item [$item]" | Out-Host

  if ($Diagnose -ne $true) {
    ./steamcmd.exe +login anonymous +workshop_download_item 365960 $item +quit
  }
}

Set-Location $originalLocation

Write-Output "====== DownloadItem script ====== DONE"
