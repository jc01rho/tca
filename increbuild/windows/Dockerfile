FROM 192.168.100.123:10301/mirror/jetbrains/teamcity-agent:2021.2-windowsservercore-1809

USER ContainerAdministrator

COPY vs_buildtools.exe vs_buildtools.exe
SHELL ["cmd", "/S", "/C"]

RUN \
    # Download the Build Tools bootstrapper.
    # curl -SL --output vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe \
    \
    # Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
    (start /w vs_buildtools.exe --quiet --wait --norestart --nocache modify \
        --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools" \
        --add Microsoft.VisualStudio.Workload.AzureBuildTools \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 \
        --remove Microsoft.VisualStudio.Component.Windows81SDK \
        || IF "%ERRORLEVEL%"=="3010" EXIT 0) \
    \
    # Cleanup
    && del /q vs_buildtools.exe

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ENV DOCKER_VERSION=20.10.9
ENV DOCKER_URL=https://download.docker.com/win/static/stable/x86_64/docker-20.10.9.zip
RUN $newPath = ('{0}\docker;{1}' -f $env:ProgramFiles, $env:PATH); \
	Write-Host ('Updating PATH: {0}' -f $newPath); \
	[Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Machine);
    
RUN Write-Host ('Downloading {0} ...' -f $env:DOCKER_URL); \
	Invoke-WebRequest -Uri $env:DOCKER_URL -OutFile 'docker.zip'; \
	\
	Write-Host 'Expanding ...'; \
	Expand-Archive docker.zip -DestinationPath $env:ProgramFiles; \
# (this archive has a "docker/..." directory in it already)
	\
	Write-Host 'Removing ...'; \
	Remove-Item @( \
			'docker.zip', \
			('{0}\docker\dockerd.exe' -f $env:ProgramFiles) \
		) -Force; \
	\
	Write-Host 'Verifying install ("docker --version") ...'; \
	docker --version; \
	\
	Write-Host 'Complete.';

USER ContainerUser