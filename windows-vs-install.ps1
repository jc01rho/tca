Write-Host "---------------------------------------------------------------"
# Write-Host "[1/2] Start Downloading Visual Studio Build Tools..."
# Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/vs_buildtools.exe" -OutFile "vs_buildtools.exe"
Write-Host "[2/2] Start Installing Visual Studio Build Tools..."
$VSId = Start-Process ".\vs_buildtools.exe" -ArgumentList "--wait --quiet --norestart --nocache install --add Microsoft.VisualStudio.Workload.VCTools  --add Microsoft.Component.MSBuild  --add Microsoft.VisualStudio.Component.VC.140  --add Microsoft.VisualStudio.Component.VC.CLI.Support  --add Microsoft.VisualStudio.Component.VC.ATL  --add Microsoft.VisualStudio.Component.VC.ATLMFC  --add Microsoft.VisualStudio.Component.Windows81SDK  --includeRecommended" -NoNewWindow -PassThru 
$VSId.WaitForExit()
$setupIds = (Get-Process -name "setup" -ErrorAction SilentlyContinue).id 
foreach ($id in $setupIds)  
{ 
    Wait-Process -Id $id -ErrorAction SilentlyContinue
}
Remove-Item "vs_buildtools.exe"
Remove-Item -path C:\Users\ContainerAdministrator\AppData\Local\Temp\ -recurse -Force
mkdir -Force -p C:\Users\ContainerAdministrator\AppData\Local\Temp