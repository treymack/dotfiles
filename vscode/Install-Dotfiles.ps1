$linkFolders = @(
"C:\Users\$env:USERNAME\scoop\apps\vscode\current\data\user-data\User\"
"C:\Users\$env:USERNAME\AppData\Roaming\Code\User"
)
$targetFolder = "C:\Users\$env:USERNAME\dotfiles\vscode"

$linkFolders | ForEach-Object {
    $linkFolder = $_
    if ((Test-Path $linkFolder) -eq $false) { mkdir $linkFolder }

    @('keybindings.json', 'settings.json', 'extensions.json') |
    ForEach-Object { cmd /c mklink "$linkFolder\$_" "$targetFolder\$_" }
}
