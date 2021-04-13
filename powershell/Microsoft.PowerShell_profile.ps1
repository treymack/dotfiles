Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

function which($cmd) {
    Get-Command $cmd | Select-Object -ExpandProperty path
}

# FUNctions!
function mdcd {
    param ($path)
    
    mkdir $path
    Set-Location $path
}

function shrug { Write-Output '¯\_(ツ)_/¯'; }
function fliptable { Write-Output '（╯°□°）╯ ┻━┻'; } # Flip a table. Example usage: fsck -y /dev/sdb1 || fliptable

Import-Module oh-my-posh
Set-PoshPrompt -Theme agnoster
