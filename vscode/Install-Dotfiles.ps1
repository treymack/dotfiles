$linkFolder = "C:\Users\$env:USERNAME\AppData\Roaming\Code\User"
$targetFolder = "C:\Users\$env:USERNAME\dotfiles\vscode"

@('keybindings.json', 'settings.json') |
    ForEach-Object { cmd /c mklink "$linkFolder\$_" "$targetFolder\$_" }
