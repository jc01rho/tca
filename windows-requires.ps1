Write-Host "---------------------------------------------------------------"
Write-Host "##teamcity[progressStart 'windows requires installing ... ']"
# Download VC++ 2010 SP1 Redistributable Package (x64)
Invoke-WebRequest http://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe  -OutFile "$env:TEMP\vc2010x64.exe" -UseBasicParsing  
Start-Process "$env:TEMP\vc2010x64.exe" '/features + /q' -wait
Remove-Item "$env:TEMP\vc2010x64.exe"

# Download VC++ 2012 Update 4 Redistributable Package (x64)
Invoke-WebRequest http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe  -OutFile "$env:TEMP\vc2012x64.exe" -UseBasicParsing  
Start-Process "$env:TEMP\vc2012x64.exe" '/features + /q' -wait
Remove-Item "$env:TEMP\vc2012x64.exe"

# Download VC++ 2013 Redistributable Package (x64)
Invoke-WebRequest http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe  -OutFile "$env:TEMP\vc2013x64.exe" -UseBasicParsing  
Start-Process "$env:TEMP\vc2013x64.exe" '/features + /q' -wait
Remove-Item "$env:TEMP\vc2013x64.exe"
