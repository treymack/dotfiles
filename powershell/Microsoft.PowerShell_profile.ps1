# Work around an RS5/PSReadline-2.0.0+beta2 bug (Spacebar is not marked 'essential')
Set-PSReadlineKeyHandler "Shift+SpaceBar" -ScriptBlock {
    [Microsoft.Powershell.PSConsoleReadLine]::Insert(' ')
}

Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
Set-PSReadlineKeyHandler -Key ctrl+l -Function ClearScreen

Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme trey
function Set-EnvVar {
    $env:POSH_AZ_SUBSCRIPTION_NAME = Get-AzContext | Select-Object -ExpandProperty "Subscription" | Select-Object -ExpandProperty "Name"
}
New-Alias -Name 'Set-PoshContext' -Value 'Set-EnvVar' -Scope Global -Force

# rancher + nerdctl
Set-Alias -Name docker -Value nerdctl

# k8s
Set-Alias k kubectl
# Set-Alias mk minikube
# try {
# following line is slow at powershell startup, commenting unless using
# docker + minikube

# & minikube -p minikube docker-env --shell powershell | Invoke-Expression
# }
# catch {
# Write-Error "Cannot connect docker.exe to minikube's dockerd"
# }
#
# if (Get-Command kubectl -ErrorAction SilentlyContinue) {
#     kubectl completion powershell | Out-String | Invoke-Expression
# }

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

function which($cmd) {
    Get-Command $cmd | Select-Object -ExpandProperty path
}

function shrug { Write-Output '¯\_(ツ)_/¯'; }
function fliptable { Write-Output '（╯°□°）╯ ┻━┻'; } # Flip a table. Example usage: fsck -y /dev/sdb1 || fliptable

function touch {
    $file = $args[0]
    if ($file -eq $null) {
        throw "No filename supplied"
    }

    if (Test-Path $file) {
        (Get-ChildItem $file).LastWriteTime = Get-Date
    }
    else {
        echo $null > $file
    }
}

$localProfile = (Join-Path '~' 'Documents\WindowsPowerShell\Microsoft.PowerShell_profile.local.ps1')
if (Test-Path $localProfile) {
    . $localProfile
}

