# Install scoop
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Scoop is already installed"
} else {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
    irm get.scoop.sh | iex
}

# # Install git
# winget install --id Git.Git -e --source winget

# Wezterm
scoop bucket add extras
scoop install wezterm
scoop install python
cd .\wezterm
.\install.ps1
cd ../

# - Add komorebi stuff
#Komorebi
scoop install whkd
scoop install komorebi
cp komorebi.json ~/
komorebic fetch-app-specific-configuration
mkdir $Env:USERPROFILE\.config -ea 0
cp whkdrc ~/.config/

# - Add yasb stuff
# yasb
mkdir $Env:USERPROFILE\.yasb -ea 0
cp .\yasb\styles.css ~\.yasb\
cp .\yasb\config.yaml ~\.yasb\

mkdir $Env:USERPROFILE\Source -ea 0
git clone https://github.com/denBot/yasb.git $Env:USERPROFILE\Source\yasb
$currentDirectory = Get-Location
cd $Env:USERPROFILE\Source\yasb
pip install -r requirements.txt
Set-Location $currentDirectory

#TODO: Make a start up script to run this thing
# - Add yasb batch file
#   - https://learn.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger?view=windowsserver2022-ps#example-5-register-a-scheduled-task-that-starts-when-a-user-logs-on

# - Add a note about https://github.com/valinet/Win11DisableRoundedCorners

# Install oh-my-posh
Install-Module PSReadLine
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
cp myposh.omp.json ~/
$currentDirectory = Get-Location
cd $env:LOCALAPPDATA\Programs\oh-my-posh\bin
.\oh-my-posh.exe init pwsh --config "~/myposh.omp.json" | Invoke-Expression
.\oh-my-posh font install --user "Meslo"
Set-Location $currentDirectory

# IDK part 1
md -Force (Split-Path $PROFILE)
cp windows\profile.ps1 $PROFILE

# IDK part 2
./set_terminal_settings.ps1

# Install neovim
scoop bucket add main
scoop install neovim
scoop install extras/vcredist2022
scoop install zig
scoop install nodejs-lts

# Install WSL
wsl --install

