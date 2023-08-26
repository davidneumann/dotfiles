#TODO
# - Add wezterm stuff
# Wezterm
scoop bucket add extras
scoop install wezterm
cd .\wezterm
./install.ps1
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
cp .\yasb\style.css ~/.yasb
cp .\yasb\config.yaml ~/.yasb

mkdir $Env:USERPROFILE\Source -ea 0
git clone https://github.com/denBot/yasb.git $Env:USERPROFILE\Source\yasb
cd $Env:USERPROFILE\Source\yasb
pip install -r requirements.txt
#TODO: Make a start up script to run this thing
# - Add yasb batch file
#   - https://learn.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger?view=windowsserver2022-ps#example-5-register-a-scheduled-task-that-starts-when-a-user-logs-on

# - Add a note about https://github.com/valinet/Win11DisableRoundedCorners

# Install oh-my-posh
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
cp myposh.omp.json ~/
oh-my-posh init pwsh --config "~/myposh.omp.json" | Invoke-Expression
cp windows\profile.ps1 $PROFILE

# IDK
./set_terminal_settings.ps1
