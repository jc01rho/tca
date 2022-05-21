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
@REM docker build -f "generated/windows/Agent/windowsservercore/1809/Dockerfile" -t sparrow-harbor.fasoo.com:32023/infra/teamcity-agent-windows:%arg1%-sparrow-1 -t sparrow-harbor.fasoo.com:32023/infra/teamcity-agent-windows:latest "context"

mkdir LLVM32
mkdir boost160_x86
xcopy C:\LLVM32 LLVM32 /s /k /e /y /h /q
xcopy C:\boost160_x86 boost160_x86 /s /k /e /y /h /q

docker build -f "increbuild/windows/Dockerfile" -t sparrow-harbor.fasoo.com:32023/infra/teamcity-agent-windows:2021.2.3-sparrow-3  -t sparrow-harbor.fasoo.com:32023/infra/teamcity-agent-windows:latest .
@REM docker push sparrow-harbor.fasoo.com:32023/infra/teamcity-agent-windows:2021.2.3-sparrow-1
@REM docker push sparrow-harbor.fasoo.com:32023/infra/teamcity-agent-windows:2021.2.2-sparrow-4
@REM docker push sparrow-harbor.fasoo.com:32023/infra/teamcity-agent-windows:latest

rmdir /s /q LLVM32
rmdir /s /q boost160_x86
