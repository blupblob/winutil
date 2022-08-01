<#
.NOTES
   Author      : WolfSense IT Security
   GitHub      : https://github.com/blupblop
    Version 0.0.1
#>


# WinGet controle
Write-Host "Kijken of Winget geinstalleerd is..."

# Er wordt gecontroleerd of Winget is geinstalleerd
if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe){
    'Winget is geinstalleerd'
}  
else{
    # Winget wordt geinstalleerd vanuit de Microsoft Store
	Write-Host "Winget is niet gevonden, het installeren begint nu."
	Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget" /quiet
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
	Write-Host Winget is geinstalleerd
    $ResultText.text = "`r`n" +"`r`n" + "Winget is nu geinstalleerd"
}

Write-Output "Apps installeren"
$apps = @(
    @{name = "7zip.7zip" },
    @{name = "Adobe.Acrobat.Reader.64-bit" },
    @{name = "Google.Chrome" },
#    @{name = "Famatech.AdvancedIPScanner" },
    @{name = "Notepad++.Notepad++" },
    @{name = "PuTTY.PuTTY" },
#    @{name = "AnyDeskSoftwareGmbH.AnyDesk" },
#    @{name = "TeamViewer.TeamViewer" },
#    @{name = "Fortinet.FortiClientVPN" },
#    @{name = "TeamViewer.TeamViewer" },
#    @{name = "Greenshot.Greenshot" },
#    @{name = "Microsoft.dotnet" },
#    @{name = "Microsoft.PowerShell" },
#    @{name = "Microsoft.PowerToys" },
#    @{name = "Microsoft.WindowsTerminal" },
#    @{name = "Mozilla.Firefox" },
#    @{name = "Microsoft.Office" },
#    @{name = "Cisco.WebexTeams" },
#    @{name = "Zoom.Zoom" }
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installeren: " $app.name
        winget install -e -h --accept-source-agreements --accept-package-agreements --id $app.name 
    }
    else {
        Write-host "Skipping: " $app.name " (is al geinstalleerd)"
    }
}
