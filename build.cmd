@REM set arg1=%1

@REM wget -c https://download.jetbrains.com/teamcity/TeamCity-%arg1%.tar.gz
@REM tar -zxvf TeamCity-%arg1%.tar.gz -C context

@REM call generate.cmd
@REM call context.cmd


@REM docker pull mcr.microsoft.com/windows/nanoserver:1809
@REM docker pull mcr.microsoft.com/powershell:nanoserver-1809
@REM docker pull mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019
@REM echo TeamCity/webapps > context/.dockerignore
@REM echo TeamCity/devPackage >> context/.dockerignore
@REM echo TeamCity/lib >> context/.dockerignore
@REM docker build -f "generated/windows/MinimalAgent/nanoserver/1809/Dockerfile" -t teamcity-minimal-agent:local-nanoserver-1809 "context"
@REM docker build -f "generated/windows/Agent/windowsservercore/1809/Dockerfile" -t 192.168.100.123:10301/infra/teamcity-agent-windows:%arg1%-sparrow-1 -t 192.168.100.123:10301/infra/teamcity-agent-windows:latest "context"

docker build -f "increbuild/windows/Dockerfile" -t 192.168.100.123:10301/infra/teamcity-agent-windows:2021.2-sparrow-1 -t 192.168.100.123:10301/infra/teamcity-agent-windows:latest "context"
docker login -u admin -p 1234 192.168.100.123:10301
docker push 192.168.100.123:10301/infra/teamcity-agent-windows:2021.2-sparrow-1
docker push 192.168.100.123:10301/infra/teamcity-agent-windows:latest


