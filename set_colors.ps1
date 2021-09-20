#Color schemes
$color_scheme = Get-Content "color_scheme.json" | Out-String | ConvertFrom-Json

echo "Adding scheme $($color_scheme.name) to terminal colors"
$settingLocations = @('%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json', 
	'%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json',
	'%LOCALAPPDATA%\Microsoft\Windows Terminal\settings.json',
	"$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json")

function Add-Color {
	param ($Path)
	$jsonfile = $Path

	$json = Get-Content $jsonfile | Out-String | ConvertFrom-Json

	#Add color scheme
	$current = $json.schemes | Where-Object -Property name -EQ $color_scheme.name 
	if ($current) {
		$json.schemes = @($json.schemes | ForEach-Object -Process {
			if ($_.name -eq $color_scheme.name) {
				return $color_scheme
			}
			$_
		})
	}
	else {
		$json.schemes += $color_scheme
	}

	#Set color scheme
	#default
	$json.profiles.defaults | Add-Member -NotePropertyName colorScheme -NotePropertyValue $color_scheme.name -Force
	#override any explicty set ones
	$json.profiles.list = @($json.profiles.list | ForEach-Object -Process {
		if ($_.commandline -eq "powershell.exe") {
			$_ | Add-Member -NotePropertyName colorScheme -NotePropertyValue $color_scheme.name -Force
		}
		$_
	})

	$json | ConvertTo-Json -Depth 100 | Set-Content $Path
}

foreach ($path in $settingLocations) {
	if (Test-Path $path) {
		Add-Color -Path $path
	}
}
