if (!(Get-Command 'nvim' -ErrorAction Ignore)) {
    throw 'Program nvim is not installed.'
}
if (!(Get-Command 'git' -ErrorAction Ignore)) {
    throw 'Program git is not installed.'
}
if (!(Test-Path "$PSScriptRoot\win.init.vim" -ErrorAction Ignore)) {
    throw 'File "win.init.vim" is not found.'
}

Set-Variable URL -Option ReadOnly -Value 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
Set-Variable PATH -Option ReadOnly -Value "$HOME\AppData\Local\nvim"

Write-Host 'Removing existing configs...'
Remove-Item "$HOME\AppData\Local\nvim" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host 'Setting up configs...'
New-Item -Path "$PATH\autoload\" -ItemType Directory -Force | Out-Null
Copy-Item -Path "$PSScriptRoot\win.init.vim" -Destination "$PATH\init.vim"
Invoke-WebRequest $URL -OutFile "$PATH\autoload\plug.vim" -ErrorAction SilentlyContinue | Out-Null
if ($?) {
    nvim -c "PlugInstall" -c "qa!"
    Write-Host 'Initialisation complete.'
    exit 0
} else {
    Write-Host 'Failed to get vim-plug.'
    exit 1
}
