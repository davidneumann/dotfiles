#Install choco
if (!(Get-Command "choco" -errorAction SilentlyContinue)) {
	echo "You need to install choco from either https://chocolatey.org/install or run .\windows\install_choco.ps1 as admin"
	exit
	#TODO figure out how to start .\windows\install_choco.ps1 as admin
}

#Install scoop
if (!(Get-Command "scoop" -errorAction SilentlyContinue)) {
	echo "You need to install scoop: https://scoop.sh/ or use .\windows\install_scoop.ps1 as an admin"
	exit
	#TODO figure out how to start .\windows\install_scoop.ps1 as admin
}

#install windows terminal
if (!(Get-Command "wt.exe" -errorAction SilentlyContinue)) {
	echo "Installing choco with 'choco install microsoft-windows-terminal'"
	choco install microsoft-windows-terminal
    exit
}

# Download font. TODO
echo "Downloading and installing Meslo font"
$fontSourceFolder = "$HOME\Downloads\Meslo\"
if (!(Test-Path ~\Downloads\Meslo.zip)) {
	Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip" -Outfile ~/Downloads/Meslo.zip
}
if (!(Test-Path $fontSourceFolder)) {
	Expand-Archive ~\Downloads\Meslo.zip -DestinationPath $fontSourceFolder
    echo "Install all these fonts by hand. Select all -> right click -> install. Rerun install afterwards"
    explorer "$fontSourceFolder"
    exit
}

#Install posh / oh-my-posh
echo "Setting up oh-my-posh"
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser -RequiredVersion 2.0.412
Update-Module oh-my-posh
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
Set-PoshPrompt -Theme emodipt
cp windows\profile.ps1 $PROFILE

./set_terminal_settings.ps1


# Run other installers
$cd = $pwd
cd vimrc
./install.ps1
cd $cd
