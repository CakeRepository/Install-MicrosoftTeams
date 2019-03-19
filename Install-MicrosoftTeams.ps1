
<#PSScriptInfo

.VERSION 1.0.2

.GUID 6d0a2fb7-8b5c-422e-8c61-f9bdf9e41fc3

.AUTHOR Justin Trantham

.COMPANYNAME Takescake Tech

.TAGS
MicrosoftTeams
Install
Teams
All user

.LICENSEURI
https://github.com/CakeRepository/Install-MicrosoftTeams/blob/master/LICENSE

.PROJECTURI
https://github.com/CakeRepository/Install-MicrosoftTeams

.RELEASENOTES
1.0 First Publish
1.0.1 Added to Script info

#>

<# 

.DESCRIPTION 
 Installs Microsoft Teams in all user mode from Microsoft website
 Documentation https://docs.microsoft.com/en-us/microsoftteams/msi-deployment

#> 
Param(
$url,
$TeamsPath = "c:\temp\teams.msi"
)

$url32 = 'https://aka.ms/teams32bitmsi'
$url64 = 'https://aka.ms/teams64bitmsi'

if(!$url){
    if([Environment]::Is64BitOperatingSystem){
        $url = $url64
    }
    else{
        $url = $url32
    }
}

$client = new-object System.Net.WebClient
$client.DownloadFile($url,$TeamsPath) 

$return = Start-Process msiexec.exe -Wait -ArgumentList "/I $TeamsPath /qn /norestart"  -PassThru

if(@(0,3010) -contains $return.ExitCode){
return 'Installed'
}
else{
return 'Error Installing'
}