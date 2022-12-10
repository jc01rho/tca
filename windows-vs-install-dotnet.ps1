Write-Host "---------------------------------------------------------------"
Write-Host "##teamcity[progressStart 'MSbuild dotnet installing ... ']"
Write-Host "[1/2] Start Downloading Visual Studio dotnet Build Tools..."
Invoke-WebRequest "https://download.microsoft.com/download/4/3/B/43B61315-B2CE-4F5B-9E32-34CCA07B2F0E/NDP452-KB2901951-x86-x64-DevPack.exe" -OutFile "dotnet.exe" -UseBasicParsing
Write-Host "[2/2] Start Installing Visual Studio dotnet Build Tools..."
# Start-Process  -NoNewWindow -PassThru -FilePath  ".\BuildTools_Full13.exe" -ArgumentList "/install","/quiet" ;  

$VSId = Start-Process ".\dotnet.exe" -ArgumentList  "/install","/quiet" -NoNewWindow -PassThru 
$VSId.WaitForExit()
$setupIds = (Get-Process -name "setup" -ErrorAction SilentlyContinue).id 
foreach ($id in $setupIds)  
{ 
    Wait-Process -Id $id -ErrorAction SilentlyContinue
}
# Remove-Item "BuildTools_Full13.exe"
Write-Host "[3/2] delete temp of Visual Studio dotnet Build Tools..."
Remove-Item -path C:\Users\ContainerAdministrator\AppData\Local\Temp\ -recurse -Force
mkdir -Force -p C:\Users\ContainerAdministrator\AppData\Local\Temp
Write-Host "##teamcity[progressFinish 'MSbuild dotnet installing ... ']"
