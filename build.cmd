set arg1=%1

wget -c https://download.jetbrains.com/teamcity/TeamCity-%arg1%.tar.gz
tar -zxvf TeamCity-%arg1%.tar.gz -C context

call generate.cmd
call context.cmd


docker pull mcr.microsoft.com/windows/nanoserver:1809
docker pull mcr.microsoft.com/powershell:nanoserver-1809
docker pull mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019
echo TeamCity/webapps > context/.dockerignore
echo TeamCity/devPackage >> context/.dockerignore
echo TeamCity/lib >> context/.dockerignore
docker build -f "generated/windows/MinimalAgent/nanoserver/1809/Dockerfile" -t teamcity-minimal-agent:local-nanoserver-1809 "context"
docker build -f "generated/windows/Agent/windowsservercore/1809/Dockerfile" -t 192.168.100.123:10301/infra/teamcity-agent-windows:%arg1%-sparrow-1 -t 192.168.100.123:10301/infra/teamcity-agent-windows:latest "context"

docker login -u admin -p 1234 192.168.100.123:10301
docker push 192.168.100.123:10301/infra/teamcity-agent-windows:%arg1%-sparrow-1 
docker push 192.168.100.123:10301/infra/teamcity-agent-windows:latest


