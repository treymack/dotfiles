$linkFolder = "C:\Users\$env:USERNAME\Documents\WindowsPowerShell"
$targetFolder = "C:\Users\$env:USERNAME\dotfiles\powershell"

@('Microsoft.PowerShell_profile.ps1') |
    ForEach-Object { cmd /c mklink /H "$linkFolder\$_" "$targetFolder\$_" }
