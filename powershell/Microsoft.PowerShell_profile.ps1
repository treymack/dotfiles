# Work around an RS5/PSReadline-2.0.0+beta2 bug (Spacebar is not marked 'essential')
Set-PSReadlineKeyHandler "Shift+SpaceBar" -ScriptBlock {
    [Microsoft.Powershell.PSConsoleReadLine]::Insert(' ')
}

Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
Set-PSReadlineKeyHandler -Key ctrl+l -Function ClearScreen

# So karma can find Chrome (installed by scoop)
$env:CHROME_BIN="C:\Users\tmack\scoop\apps\googlechrome\current\chrome.exe"

Import-Module posh-git
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\stelbent-compact.minimal.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:HOMEDRIVE\$env:HOMEPATH\dotfiles\oh-my-posh\custom.omp.json" | Invoke-Expression
function Set-EnvVar {
    # $env:POSH_AZ_SUBSCRIPTION_NAME = Get-AzContext | Select-Object -ExpandProperty "Subscription" | Select-Object -ExpandProperty "Name"
}
New-Alias -Name 'Set-PoshContext' -Value 'Set-EnvVar' -Scope Global -Force

# Set up az CLI tab completion
Register-ArgumentCompleter -Native -CommandName az -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $completion_file = New-TemporaryFile
    $env:ARGCOMPLETE_USE_TEMPFILES = 1
    $env:_ARGCOMPLETE_STDOUT_FILENAME = $completion_file
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    $env:_ARGCOMPLETE = 1
    $env:_ARGCOMPLETE_SUPPRESS_SPACE = 0
    $env:_ARGCOMPLETE_IFS = "`n"
    $env:_ARGCOMPLETE_SHELL = 'powershell'
    az 2>&1 | Out-Null
    Get-Content $completion_file | Sort-Object | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
    }
    Remove-Item $completion_file, Env:\_ARGCOMPLETE_STDOUT_FILENAME, Env:\ARGCOMPLETE_USE_TEMPFILES, Env:\COMP_LINE, Env:\COMP_POINT, Env:\_ARGCOMPLETE, Env:\_ARGCOMPLETE_SUPPRESS_SPACE, Env:\_ARGCOMPLETE_IFS, Env:\_ARGCOMPLETE_SHELL
}

# k8s
Set-Alias k kubectl
$env:KUBE_EDITOR = 'vim'
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
if (Get-Command kubectl -ErrorAction SilentlyContinue) {
    kubectl completion powershell | Out-String | Invoke-Expression
}

# if (Get-Command azcopy -ErrorAction SilentlyContinue) {
    # azcopy completion powershell | Out-String | Invoke-Expression
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

function shrug { Write-Output '??\_(???)_/??'; }
function fliptable { Write-Output '??????????????????? ?????????'; } # Flip a table. Example usage: fsck -y /dev/sdb1 || fliptable

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

