@REM @REM echo "start"
@REM @REM ping 127.0.0.1 -n 6 > nul
@REM powershell cmd /c start /w vs_buildtools.exe --quiet --wait --norestart --nocache
@REM powershell.exe -NoLogo -ExecutionPolicy Bypass cmd /c  start /w vs_buildtools.exe --quiet --wait --norestart --nocache
@REM start /w cmd /c vs_buildtools.exe --quiet --wait --norestart --nocache
@REM @REM start /w vs_buildtools.exe --quiet --wait --norestart --nocache
@REM start /w vs_buildtools.exe --quiet --wait --norestart --nocache modify  --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\BuildTools"  --add Microsoft.VisualStudio.Workload.VCTools  --add Microsoft.Component.MSBuild  --add Microsoft.VisualStudio.Component.VC.140  --add Microsoft.VisualStudio.Component.VC.CLI.Support  --add Microsoft.VisualStudio.Component.VC.ATL  --add Microsoft.VisualStudio.Component.VC.ATLMFC  --add Microsoft.VisualStudio.Component.Windows81SDK  --includeRecommended 



@REM start /w cmd /c vs_buildtools.exe --quiet --wait --norestart --nocache

@REM start /w vs_buildtools.exe --quiet --wait --norestart --nocache modify  --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\BuildTools"  --add Microsoft.VisualStudio.Workload.VCTools  --add Microsoft.Component.MSBuild  --add Microsoft.VisualStudio.Component.VC.140  --add Microsoft.VisualStudio.Component.VC.CLI.Support  --add Microsoft.VisualStudio.Component.VC.ATL  --add Microsoft.VisualStudio.Component.VC.ATLMFC  --add Microsoft.VisualStudio.Component.Windows81SDK  --includeRecommended 
@REM C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\VC\VCTargets\Microsoft.Cpp.Default.props" 프로젝트를 찾을 수 없습니다. <Import> 선언에 지정한 경로가 올바른지 그리고 파일이 디스크에 있는지 확인하세요.
@REM "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat" && powershell.exe -NoLogo -ExecutionPolicy Bypass C:\BuildAgent\run-agent.ps1
powershell.exe -NoLogo -ExecutionPolicy Bypass C:\BuildAgent\run-agent.ps1
