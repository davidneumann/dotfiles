# Create the WezTerm configuration directory

New-Item -Path "$env:USERPROFILE\.config\wezterm" -ItemType Directory -Force

# Get a list of all .lua files in the current directory

$luaFiles = Get-ChildItem -Path . -Include "*.lua" -Recurse -Force

# Remove any existing symlinks to the .lua files

Get-ChildItem -Path "$env:USERPROFILE\.config\wezterm" -Include "*.lua" -Recurse -Force | Remove-Item -Force

# Create symlinks to the .lua files in the current directory

function Start-ElevatedPS {
    param([ScriptBlock]$code)

    Start-Process -FilePath powershell.exe -Verb RunAs -ArgumentList $code
    Write-Host $code
}

foreach ($luaFile in $luaFiles) {
    Write-Host "Creating symlink for $luaFile"

    $symlinkPath = "$env:USERPROFILE\.config\wezterm\$($luaFile.Name)"

    Write-Host "Symlink path: $symlinkPath"

    Write-Host "Source path: $(pwd)\$($luaFile.Name)"

    # cmd.exe /c "mklink /d $symlinkPath $(pwd)\$($luaFile.Name)"
    $test = "$(pwd)\$($luaFile.Name)"
    $code = {
        param($symlinkPath, $test);
        Write-Host ":New-Item -Path $symlinkPath -ItemType SymbolicLink -Target $test"
        Start-Process -FilePath powershell.exe -Verb RunAs -ArgumentList "New-Item -ItemType SymbolicLink -Path $symlinkPath -Target $test"
    }
    Invoke-Command $code -ArgumentList $symlinkPath, $test
    # Start-ElevatedPS {
    # } -ArgumentList $symlinkPath, $test
    # Start-ElevatedPS { "New-Item -Name $symlinkPath -ItemType SymbolicLink -Target $test" }
}
