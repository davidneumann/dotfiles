#Use bash style tab completion
echo "Setting bash style tab completion"
Set-PSReadlineKeyHandler -Key Tab -Function Complete

#Disable bell
echo "Disabling bell"
Set-PSReadlineOption -BellStyle None

./set_colors.ps1
