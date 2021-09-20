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
}

# Download font. TODO
echo "Downloading and installing Meslo font"
if (!(Test-Path ~\Downloads\Meslo.zip)) {
	Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip" -Outfile ~/Downloads/Meslo.zip
}
if (!(Test-Path ~\Downloads\Meslo\)) {
	Expand-Archive ~\Downloads\Meslo.zip -DestinationPath ~\Downloads\Meslo\
	#Install the fonts. TODO https://stackoverflow.com/a/34802623 figure out how to do this
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
