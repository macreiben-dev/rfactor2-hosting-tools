param(
  [bool] $DiagnoseMode = $false, 
  [Parameter(Mandatory)] [string] $ServerInstallPath,
  [Parameter(Mandatory)] [string] $ShortcutSuffix,
  [string] $ShortcutDestinationPath = ".")

Write-Output "Using parameter ServerInstallPath :                 $ServerInstallPath"
Write-Output "Using parameter ShortcutDestinationPath :           $ShortcutDestinationPath"
Write-Output "Using parameter ShortcutSuffix :                    $ShortcutSuffix"

# Shorcut for dedicated server
$target_server_shortcut_name = "StartDedicatedServer_$ShortcutSuffix.lnk"
$target_server_shortcut_full_path = "$ShortcutDestinationPath\$target_server_shortcut_name"

# Shortcut for mod manager
$target_modManager_shortcut_name = "ModManager_$ShortcutSuffix.lnk"
$target_modManager_shortcut_full_path = "$ShortcutDestinationPath\$target_modManager_shortcut_name"

Write-Output "Using computedValue target_shortcut_full_path :                  $target_server_shortcut_full_path"
Write-Output "Using computedValue target_modManager_shortcut_full_path :       $target_modManager_shortcut_full_path"

$target_server_binary_name = "rFactor2 Dedicated.exe"
$target_modManager_binary_name = "ModMgr.exe"

$source_relative_install_dir = $ServerInstallPath
$source_relative_server_executable_path = "$source_relative_install_dir\Bin64\$target_server_binary_name"
$source_relative_modManager_executable_path = "$source_relative_install_dir\Bin64\$target_modManager_binary_name"

Write-Output "Using computedValue source_relative_server_executable_path :     $source_relative_server_executable_path"
Write-Output "Using computedValue source_relative_modManager_executable_path : $source_relative_modManager_executable_path"

$is_target_server_install_dir_valid = Test-Path -Path $source_relative_install_dir
$is_target_server_executable_full_valid = Test-Path -Path $source_relative_server_executable_path
$is_target_modManager_executable_path_valid = Test-Path -Path $source_relative_modManager_executable_path

# --- SANITY CHECKS ---

if ($is_target_server_install_dir_valid -ne $true) {
  Write-Error "Target server install directory is not valid."
  Write-Error "Check [ServerInstallPath] parameter values."
  Write-Error "Given ServerInstallPath was: $ServerInstallPath"
  Exit 4
}

if ($is_target_server_executable_full_valid -ne $true) {
  Write-Error "Target server executable path is not valid."
  Write-Error "Check [ServerInstallPath] parameter values."
  Write-Error "Given ServerInstallPath was: $ServerInstallPath"
  Write-Error "Computed relative path was: $source_relative_server_executable_path"
  Exit 5
}

if ($is_target_modManager_executable_path_valid -ne $true) {
  Write-Error "Target server mod manager path is not valid."
  Write-Error "Check [ServerInstallPath] parameter values."
  Write-Error "Given ServerInstallPath was: $ServerInstallPath"
  Write-Error "Computed relative path was: $is_target_modManager_executable_path_valid"
  Exit 5
}

# --- SANITY CHECKS --- ___END___

$target_server_install_dir = Resolve-Path $source_relative_install_dir
$target_server_executable_full_path = Resolve-Path $source_relative_server_executable_path
$target_modManager_executable_full_path = Resolve-Path $source_relative_modManager_executable_path

if ($DiagnoseMode) {
  Write-Output "!!!! Diagnose mode is one, don't do anything for real. !!!!"
  Exit
}

$WshShell = New-Object -comObject WScript.Shell

Write-Output ">>> Creating server shortcut ..."

Write-Output "Using target_server_shortcut_full_path:               $target_server_shortcut_full_path"
Write-Output "Using target_server_executable_full_path:             $target_server_executable_full_path"
Write-Output "Using target_server_install_dir:                      $target_server_install_dir"

$Shortcut = $WshShell.CreateShortcut($target_server_shortcut_full_path)
$Shortcut.TargetPath = $target_server_executable_full_path
$Shortcut.WorkingDirectory = $target_server_install_dir
$Shortcut.save()

Write-Output ">>> Server shortcut created."

Write-Output ">>> Creating ModManager shortcut ..."

Write-Output "Using target_modManager_shortcut_full_path:           $target_modManager_shortcut_full_path"
Write-Output "Using target_modManager_executable_full_path:         $target_modManager_executable_full_path"
Write-Output "Using target_server_install_dir:                      $target_server_install_dir"

$Shortcut2 = $WshShell.CreateShortcut($target_modManager_shortcut_full_path)
$Shortcut2.TargetPath = $target_modManager_executable_full_path
$Shortcut2.WorkingDirectory = $target_server_install_dir
$Shortcut2.save()

Write-Output ">>> ModManager shortcut created."