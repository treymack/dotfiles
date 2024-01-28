$linkFolders = @(
    "C:\Users\$env:USERNAME\Documents\WindowsPowerShell"
    "C:\Users\$env:USERNAME\Documents\PowerShell"
    "C:\Users\$env:USERNAME\OneDrive\Documents\WindowsPowerShell"
    "C:\Users\$env:USERNAME\OneDrive\Documents\PowerShell"
)
$targetFolder = "C:\Users\$env:USERNAME\dotfiles\powershell"

scoop install posh-git
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json

@('Microsoft.PowerShell_profile.ps1') |
ForEach-Object {
    $filename = $_
    $linkFolders | ForEach-Object {
        $linkFolder = $_
        if ((Test-Path $linkFolder) -eq $false) { mkdir $linkFolder }
        cmd /c mklink /H "$linkFolder\$filename" "$targetFolder\$filename" 
    }
}
