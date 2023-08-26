#Use bash style tab completion
Set-PSReadlineKeyHandler -Key Tab -Function Complete

#Disable bell
Set-PSReadlineOption -BellStyle None

# #Posh stuff
# Import-Module posh-git
# Import-Module oh-my-posh
# Set-PoshPrompt -Theme emodipt
oh-my-posh init pwsh --config "$HOME/myposh.omp.json" | Invoke-Expression