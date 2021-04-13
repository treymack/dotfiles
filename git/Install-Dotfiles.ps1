$linkFolder = "C:\Users\$env:USERNAME"
$targetFolder = "C:\Users\$env:USERNAME\dotfiles\git"

@('.gitconfig') |
    ForEach-Object { cmd /c mklink /H "$linkFolder\$_" "$targetFolder\$_" }
