# Work around an RS5/PSReadline-2.0.0+beta2 bug (Spacebar is not marked 'essential')
Set-PSReadlineKeyHandler "Shift+SpaceBar" -ScriptBlock {
    [Microsoft.Powershell.PSConsoleReadLine]::Insert(' ')
}

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

function gitbash { & 'C:\Program Files\Git\bin\bash.exe' }

function touch
{
    $file = $args[0]
    if($file -eq $null) {
        throw "No filename supplied"
    }

    if(Test-Path $file)
    {
        (Get-ChildItem $file).LastWriteTime = Get-Date
    }
    else
    {
        echo $null > $file
    }
}

$localProfile = (Join-Path '~' 'Documents\WindowsPowerShell\Microsoft.PowerShell_profile.local.ps1')
if (Test-Path $localProfile) {
    . $localProfile
}

