Write-Host "---------------------------------------------------------------"
Write-Host "##teamcity[progressStart 'MSbuild 17 installing ... ']"
# Write-Host "[1/2] Start Downloading Visual Studio Build Tools..."
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vs_buildtools.exe" -OutFile "vs_buildtools17.exe"
Write-Host "[2/2] Start Installing Visual Studio Build Tools..."
$VSId = Start-Process ".\vs_buildtools17.exe" -ArgumentList "--wait --quiet --norestart --nocache install --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Product.BuildTools --add Microsoft.Component.MSBuild  --add Microsoft.VisualStudio.Component.VC.140  --add Microsoft.VisualStudio.Component.VC.CLI.Support  --add Microsoft.VisualStudio.Component.VC.ATL  --add Microsoft.VisualStudio.Component.VC.ATLMFC  --add Microsoft.VisualStudio.Component.Windows81SDK  --add Microsoft.VisualStudio.Component.VSSDKBuildTools  --add Microsoft.VisualStudio.Component.Windows10SDK.17134 --add Microsoft.VisualStudio.Component.VSSDKBuildTools --add Microsoft.VisualStudio.Workload.NetCoreBuildTools --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools --add Microsoft.VisualStudio.Workload.DataBuildTools --add Microsoft.VisualStudio.Workload.UniversalBuildTools --add Microsoft.VisualStudio.Workload.VisualStudioExtensionBuildTools  --includeRecommended" -NoNewWindow -PassThru 
$VSId.WaitForExit()
$setupIds = (Get-Process -name "setup" -ErrorAction SilentlyContinue).id 
foreach ($id in $setupIds)  
{ 
    Wait-Process -Id $id -ErrorAction SilentlyContinue
}
# Remove-Item "vs_buildtools17.exe"
Remove-Item -path C:\Users\ContainerAdministrator\AppData\Local\Temp\ -recurse -Force
mkdir -Force -p C:\Users\ContainerAdministrator\AppData\Local\Temp
Write-Host "##teamcity[progressFinish 'MSbuild 17 installing ... ']"
