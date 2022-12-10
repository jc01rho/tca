Write-Host "---------------------------------------------------------------"
Write-Host "##teamcity[progressStart 'MSbuild 14 installing ... ']"
Write-Host "[1/2] Start Downloading Visual Studio Build Tools..."
Invoke-WebRequest "https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe" -OutFile "BuildTools_Full14.exe" -UseBasicParsing
Write-Host "[2/2] Start Installing Visual Studio Build Tools..."
$VSId = Start-Process ".\BuildTools_Full14.exe" -ArgumentList '/NoRestart /S'  -NoNewWindow -PassThru   

# $VSId = Start-Process ".\vs_buildtools14.exe" -ArgumentList "--wait --quiet --norestart --nocache install --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Workload.MSBuildTools --add Microsoft.Component.MSBuild  --add Microsoft.VisualStudio.Component.VC.140  --add Microsoft.VisualStudio.Component.VC.CLI.Support  --add Microsoft.VisualStudio.Component.VC.ATL  --add Microsoft.VisualStudio.Component.VC.ATLMFC  --add Microsoft.VisualStudio.Component.Windows81SDK  --add Microsoft.VisualStudio.Component.Windows10SDK.17134 --add Microsoft.VisualStudio.Component.VSSDKBuildTools --add Microsoft.VisualStudio.Workload.NetCoreBuildTools --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools --add Microsoft.VisualStudio.Workload.DataBuildTools --add Microsoft.VisualStudio.Workload.UniversalBuildTools --add Microsoft.VisualStudio.Workload.VisualStudioExtensionBuildTools --includeRecommended" -NoNewWindow -PassThru 
$VSId.WaitForExit()
$setupIds = (Get-Process -name "setup" -ErrorAction SilentlyContinue).id 
foreach ($id in $setupIds)  
{ 
    Wait-Process -Id $id -ErrorAction SilentlyContinue
}
# Remove-Item "BuildTools_Full14.exe"
Remove-Item -path C:\Users\ContainerAdministrator\AppData\Local\Temp\ -recurse -Force
mkdir -Force -p C:\Users\ContainerAdministrator\AppData\Local\Temp
Write-Host "##teamcity[progressFinish 'MSbuild 14 installing ... ']"
