# escape=`

FROM sparrow-harbor.fasoo.com:32023/mirror/jetbrains/teamcity-agent:2021.2.3-windowsservercore
# FROM sparrow-harbor.fasoo.com:32023/infra/teamcity-agent-windows:2021.2.3-sparrow-17-test





COPY windows-requires.ps1 C:/
COPY windows-vs-install-dotnet.ps1 C:/
COPY windows-vs-install13.ps1 C:/
COPY windows-vs-install14.ps1 C:/
COPY windows-vs-install15.ps1 C:/
COPY windows-vs-install16.ps1 C:/
COPY windows-vs-install17.ps1 C:/

USER "NT Authority\System"
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN  powershell .\windows-requires.ps1; powershell .\windows-vs-install13.ps1; powershell .\windows-vs-install-dotnet.ps1;  powershell .\windows-vs-install14.ps1; powershell .\windows-vs-install15.ps1; powershell .\windows-vs-install16.ps1; powershell .\windows-vs-install17.ps1 ; powershell -Command Remove-Item .\windows-requires.ps1; Remove-Item .\windows-vs-install-dotnet.ps1; Remove-Item .\windows-vs-install13.ps1; Remove-Item .\windows-vs-install14.ps1; Remove-Item .\windows-vs-install15.ps1; Remove-Item .\windows-vs-install16.ps1; Remove-Item .\windows-vs-install17.ps1;


RUN [Environment]::SetEnvironmentVariable("JDK_13", "C:\Program Files\Java\13", "Machine")
RUN [Environment]::SetEnvironmentVariable("JDK_1_8", "C:\Program Files\Java\1.8", "Machine")





USER ContainerAdministrator
# COPY context/run-agent.ps1 ./BuildAgent/.

# Copy our Install script.
SHELL ["cmd", "/S", "/C"]

RUN curl --insecure -O https://nexus.sparrow.local/repository/sparrow/infra/rootca.crt
RUN keytool  -noprompt -importcert -cacerts -storepass changeit -file rootca.crt -alias sparrow.local;

COPY Install.cmd C:/TEMP/
COPY sdksetup.exe .




ADD https://aka.ms/vscollect.exe C:/TEMP/collect.exe
ADD manualRun.cmd C:/manualRun.cmd
ARG CHANNEL_URL=https://aka.ms/vs/15/release/channel
ADD ${CHANNEL_URL} C:/TEMP/VisualStudio.chman








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


RUN Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) ; choco feature enable -n=allowGlobalConfirmation ; choco install cmake --installargs 'ADD_CMAKE_TO_PATH=System' -y --no-progress ; choco install maven; choco install python ; choco install rustup.install -y; git config --system core.longpaths true



SHELL ["cmd", "/S", "/C"]
RUN `
    # Download the Build Tools bootstrapper.
	curl -SL --output java_1.8.zip https://cdn.azul.com/zulu/bin/zulu8.60.0.21-ca-jdk8.0.322-win_x64.zip  & `
	curl -SL --output java_13.zip https://cdn.azul.com/zulu/bin/zulu13.46.15-ca-jdk13.0.10-win_x64.zip
#   The command 'cmd /S /C curl -SL --output java_1.8.zip https://cdn.azul.com/zulu/bin/zulu8.60.0.21-ca-jdk8.0.322-win_x64.zip  &   curl -SL --output java_13.zip https://cdn.azul.com/zulu/bin/zulu13.46.15-ca-jdk13.0.10-win_x64.zip ;' returned a non-zero code: 6

SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]
RUN Expand-Archive c:\java_1.8.zip -DestinationPath 'C:\Program Files\Java\1.8' ; `
	Expand-Archive c:\java_13.zip -DestinationPath 'C:\Program Files\Java\13' ; `
	Remove-Item -path c:\java_13.zip -recurse -Force; `
	Remove-Item -path c:\java_1.8.zip -recurse -Force; 

RUN $newPath = ('{0}\Java\1.8\bin;{1}' -f $env:ProgramFiles, $env:PATH); `
	Write-Host ('Updating PATH: {0}' -f $newPath); `
	[Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Machine); `
	[Environment]::SetEnvironmentVariable("JDK_13", "C:\Program Files\Java\13", "Machine"); 



RUN $newPath = ('{0}\Java\13\bin;{1}' -f $env:ProgramFiles, $env:PATH); `
	Write-Host ('Updating PATH: {0}' -f $newPath); `
	[Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Machine); `
	[Environment]::SetEnvironmentVariable("JDK_1_8", "C:\Program Files\Java\1.8", "Machine");







SHELL ["cmd", "/S", "/C"]

COPY LLVM64/ C:/LLVM64/
COPY boost160_x64/ C:/boost160_x64/


COPY entrypoint.cmd "c:\\"



ENTRYPOINT ["cmd"]
CMD ["/c", "c:\\entrypoint.cmd"]