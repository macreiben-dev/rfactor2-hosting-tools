param(
  [bool] $DiagnoseMode = $false,
  [string] $SteamCMDFolder = "steamCMD",
  [string] $SteamCMDDownloadUrl = "http://media.steampowered.com/installer/steamcmd.zip",
  [Parameter(Mandatory)] [string] $Rf2InstallationDirectory
)
Write-Output "Using parameter SteamCMDFolder :              $SteamCMDFolder"
Write-Output "Using parameter SteamCMDDownloadUrl :         $SteamCMDDownloadUrl"
Write-Output "Using parameter Rf2InstallationDirectory :    $Rf2InstallationDirectory"

$steamCmdDownloadUrl = $SteamCMDDownloadUrl
$steamCmdFolder = $SteamCMDFolder

$is_steamCmdFolder_exist = Test-Path -Path $SteamCMDFolder
$is_rf2_installation_exist = Test-Path -Path $Rf2InstallationDirectory

if ($is_steamCmdFolder_exist) {
  Write-Output "SteamCMD folder exists, removing ..."
  Remove-Item -Recurse -Force $SteamCMDFolder
  Write-Output "SteamCMD folder removed."
}

if ($is_rf2_installation_exist) {
  Write-Output "Rf2InstallationDirectory folder exists, removing ..."
  Remove-Item -Recurse -Force $Rf2InstallationDirectory
  Write-Output "Rf2InstallationDirectory folder removed."
}

# Download steam cmd
Invoke-WebRequest $steamCmdDownloadUrl -OutFile "steamcmd.zip"

Write-Output "Extracting steamCMD archive to [$SteamCMDFolder] ..."
Expand-Archive "steamcmd.zip" -DestinationPath $SteamCMDFolder
Write-Output "Extracting steamCMD archive to [$SteamCMDFolder], done."

Write-Output "Creating RF2 dedicated server installation folder [$Rf2InstallationDirectory] ..."
New-Item $Rf2InstallationDirectory -ItemType Directory | Out-Null
Write-Output "Creating RF2 dedicated server installation folder [$Rf2InstallationDirectory], done."

if ($DiagnoseMode) {
  Write-Output "DIAGNOSTIC MODE ON: won't do anything but download the steam cmd and extract it."
  Exit
}

# Backup original location
$originalLocation = Get-Location 

Set-Location $SteamCMDFolder

./steamcmd.exe +login anonymous +force_install_dir ../$Rf2InstallationDirectory +app_update 400300 +quit

Set-Location $originalLocation