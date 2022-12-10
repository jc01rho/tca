Write-Host "---------------------------------------------------------------"
Write-Host "##teamcity[progressStart 'MSbuild 13 installing ... ']"
Write-Host "[1/2] Start Downloading Visual Studio 13 Build Tools..."
Invoke-WebRequest "https://download.microsoft.com/download/9/B/B/9BB1309E-1A8F-4A47-A6C5-ECF76672A3B3/BuildTools_Full.exe" -OutFile "BuildTools_Full13.exe" -UseBasicParsing
Write-Host "[2/2] Start Installing Visual Studio 13 Build Tools..."
# Start-Process  -NoNewWindow -PassThru -FilePath  ".\BuildTools_Full13.exe" -ArgumentList "/install","/quiet" ;  

Invoke-WebRequest "https://download.microsoft.com/download/B/0/C/B0C80BA3-8AD6-4958-810B-6882485230B5/standalonesdk/sdksetup.exe" -OutFile "sdksetup.exe" -UseBasicParsing
$VSId = Start-Process -Wait  -NoNewWindow -PassThru  ".\sdksetup.exe" -ArgumentList '/ceip off /features OptionID.NetFxSoftwareDevelopmentKit /quiet /norestart /feature +'



$VSId = Start-Process -Wait  -NoNewWindow -PassThru  ".\BuildTools_Full13.exe" -ArgumentList '/Silent /Full'
$VSId.WaitForExit()
$setupIds = (Get-Process -name "setup" -ErrorAction SilentlyContinue).id 
foreach ($id in $setupIds)  
{ 
    Wait-Process -Id $id -ErrorAction SilentlyContinue
}
# Remove-Item "BuildTools_Full13.exe"
Write-Host "[3/2] delete temp of Visual Studio 13 Build Tools..."
Remove-Item -path C:\Users\ContainerAdministrator\AppData\Local\Temp\ -recurse -Force
mkdir -Force -p C:\Users\ContainerAdministrator\AppData\Local\Temp
Write-Host "##teamcity[progressFinish 'MSbuild 13 installing ... ']"
