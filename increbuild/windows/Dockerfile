# escape=`

FROM sparrow-harbor.fasoo.com:32023/mirror/jetbrains/teamcity-agent:2021.2.3-windowsservercore

USER ContainerAdministrator
# COPY context/run-agent.ps1 ./BuildAgent/.

# Copy our Install script.
SHELL ["cmd", "/S", "/C"]
COPY Install.cmd C:/TEMP/
COPY sdksetup.exe .




ADD https://aka.ms/vscollect.exe C:/TEMP/collect.exe
ADD manualRun.cmd C:/manualRun.cmd
ARG CHANNEL_URL=https://aka.ms/vs/15/release/channel
ADD ${CHANNEL_URL} C:/TEMP/VisualStudio.chman





# RUN $ErrorActionPreference = 'Stop'; \
#     $ProgressPreference = 'SilentlyContinue'; \
#     $VerbosePreference = 'Continue'; \
#     $p = Start-Process -Wait -PassThru -FilePath vs_buildtools_15.exe -ArgumentList \
#     '--quiet --addProductLang ko-KR --includeOptional --nocache --wait --installPath %ProgramFiles(x86)%\Microsoft Visual Studio\2015\BuildTools \
#     --add Microsoft.VisualStudio.Workload.MSBuildTools \
#     '; \
#     if ($ret = $p.ExitCode) { throw ('Install failed with exit code 0x{0:x}' -f $ret) }; 
    

# RUN \
    # Download the Build Tools bootstrapper.
    # curl -SL --output vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe \
    # \
    # Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
    # (start /w vs_buildtools_15.exe --quiet --wait --norestart --nocache modify \
    #     --add Microsoft.VisualStudio.Workload.VCTools\
	# 	--includeRecommended \
	# 	--add Microsoft.VisualStudio.Component.VC.ATL \
	# 	--add Microsoft.VisualStudio.Component.VC.ATLMFC \
	# 	--add Microsoft.VisualStudio.Component.VC.CLI.Support \
	# 	--add Microsoft.VisualStudio.Workload.MSBuildTools \
    #     --add Microsoft.VisualStudio.Component.Windows10SDK.10240 \
    #     --add Microsoft.VisualStudio.Component.Windows10SDK.10586 \
    #     --add Microsoft.VisualStudio.Component.Windows10SDK.14393 \
    #     --add Microsoft.VisualStudio.Component.Windows81SDK \
    #     || IF "%ERRORLEVEL%"=="3010" EXIT 0) \
    # \
    # Cleanup
    # && del /q vs_buildtools_15.exe

# RUN (start /w BuildTools_Full.exe /Full /Q /NoRestart ) \
# 	&& (start /w visualcppbuildtools_full.exe /Full /Q /NoRestart  ) \
#     && del /q BuildTools_Full.exe && del /q visualcppbuildtools_full.exe




SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ENV DOCKER_VERSION=20.10.6
ENV DOCKER_URL=https://download.docker.com/win/static/stable/x86_64/docker-20.10.6.zip
RUN $newPath = ('{0}\docker;{1}' -f $env:ProgramFiles, $env:PATH); `
	Write-Host ('Updating PATH: {0}' -f $newPath); `
	[Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Machine);
    
RUN Write-Host ('Downloading {0} ...' -f $env:DOCKER_URL); `
	Invoke-WebRequest -Uri $env:DOCKER_URL -OutFile 'docker.zip'; `
	`
	Write-Host 'Expanding ...'; `
	Expand-Archive docker.zip -DestinationPath $env:ProgramFiles; `
# (this archive has a "docker/..." directory in it already)
	`
	Write-Host 'Removing ...'; `
	Remove-Item @( `
			'docker.zip', `
			('{0}\docker\dockerd.exe' -f $env:ProgramFiles) `
		) -Force; `
	`
	Write-Host 'Verifying install ("docker --version") ...'; `
	docker --version; `
	`
	Write-Host 'Complete.';

SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]


# RUN choco install microsoft-visual-cpp-build-tools --force -y

# due to docker pipeline, you must run win admin
# USER ContainerUser

#CMD powershell Start-Sleep -s 20; docker network create --driver nat nat-driver ; ./BuildAgent/run-agent.ps1
# RUN  (Get-Content "./BuildAgent/run-agent.ps1") | Add-Content "./BuildAgent/run-sparrow-agent.ps1";



# ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat -arch=amd64 -host_arch=amd64 &&

# CMD pwsh ./BuildAgent/run-sparrow-agent.ps1

COPY config.json C:/Users/ContainerAdministrator/.docker/config.json
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


RUN choco feature enable -n=allowGlobalConfirmation
RUN choco install cmake --installargs 'ADD_CMAKE_TO_PATH=System' -y --no-progress


COPY LLVM32/ C:/LLVM32/
COPY boost160_x86/ C:/boost160_x86/

RUN choco install maven

SHELL ["cmd", "/S", "/C"]


RUN `
    # Download the Build Tools bootstrapper.
    curl -SL --output vs_buildtools.exe https://aka.ms/vs/15/release/vs_buildtools.exe   & `
	curl -SL --output java_1.8.zip https://cdn.azul.com/zulu/bin/zulu8.60.0.21-ca-jdk8.0.322-win_x64.zip & ` 
	curl -SL --output java_13.zip https://cdn.azul.com/zulu/bin/zulu13.46.15-ca-jdk13.0.10-win_x64.zip & `
    # `
    # # Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
	# 	# --channelUri C:\TEMP\VisualStudio.chman `
    #     # --installChannelUri C:\TEMP\VisualStudio.chman `
	# 	# --includeRecommended `
	# & 하나로 바꿔서 빌드 되는지 확인하고, java 압축해제 및 path 등록 스크립트화 해서 다시 빌드해보기
	powershell cmd /c start /w vs_buildtools.exe --quiet --wait --norestart --nocache & `
    start /w vs_buildtools.exe --quiet --wait --norestart --nocache & `
	start /w vs_buildtools.exe --quiet --wait --norestart --nocache modify  --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\BuildTools"  --add Microsoft.VisualStudio.Workload.VCTools  --add Microsoft.Component.MSBuild  --add Microsoft.VisualStudio.Component.VC.140  --add Microsoft.VisualStudio.Component.VC.CLI.Support  --add Microsoft.VisualStudio.Component.VC.ATL  --add Microsoft.VisualStudio.Component.VC.ATLMFC  --add Microsoft.VisualStudio.Component.Windows81SDK  --includeRecommended 
    #     --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\BuildTools" `
    #     --add Microsoft.VisualStudio.Workload.VCTools `
	# 	--add Microsoft.Component.MSBuild `
    #     --add Microsoft.VisualStudio.Component.VC.140 `
    #     --add Microsoft.VisualStudio.Component.VC.CLI.Support `
	# 	--add Microsoft.VisualStudio.Component.VC.ATL `
	# 	--add Microsoft.VisualStudio.Component.VC.ATLMFC `
	# 	--add Microsoft.VisualStudio.Component.Windows81SDK `
	# 	--includeRecommended `
    # # Cleanup
	# && (start /w sdksetup.exe /features + /q /norestart) `
	# && del /q sdksetup.exe 



COPY entrypoint.cmd "c:\\"
# RUN `
# 	curl -SL --output vs_buildtools.exe https://aka.ms/vs/15/release/vs_buildtools.exe  && `
# 	start /w vs_buildtools.exe --quiet --wait --norestart --nocache




# ENTRYPOINT ["cmd","/c", "c:\\entrypoint.cmd"]


ENTRYPOINT ["cmd"]
CMD ["/c", "c:\\entrypoint.cmd"]