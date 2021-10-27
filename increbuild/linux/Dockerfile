FROM 192.168.100.123:10301/mirror/jetbrains/teamcity-agent:2021.2-linux-sudo

USER root


RUN apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    # https://github.com/goodwithtech/dockle/blob/master/CHECKPOINT.md#dkl-di-0005
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/apt/lists/*

RUN bash -c 'echo "DOCKER_OPTS=\"--insecure-registry 192.168.11.124:8082 --insecure-registry 192.168.11.124:8099  --insecure-registry 192.168.100.123:10301 \"" >> /etc/default/docker'
RUN service docker restart; exit 0

USER buildagent

RUN mkdir ~/.m2; cd ~/.m2; echo "<?xml version="1.0" encoding="UTF-8"?>\n\ 
  <settings xmlns="http://maven.apache.org/SETTINGS/1.1.0"\n\ 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n\ 
    xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">\n\ 
  <servers>\n\ 
      <server>\n\ 
        <id>Releases</id>\n\ 
        <username>admin</username>\n\ 
        <password>sparrow</password>\n\ 
     </server>\n\ 
      <server>\n\ 
        <id>Snapshots</id>\n\ 
        <username>admin</username>\n\ 
        <password>sparrow</password>\n\ 
      </server>\n\ 
     <server>\n\ 
        <id>SparrowNexus</id>\n\ 
        <username>admin</username>\n\ 
        <password>1234</password>\n\ 
      </server>\n\ 
  </servers>\n\ 
   <mirrors>\n\ 
           <mirror>\n\ 
            <id>SparrowNexus</id>\n\ 
            <mirrorOf>central</mirrorOf>\n\ 
            <name>Maven central https</name>\n\ 
            <url>http://192.168.100.123:8081/repository/public/</url>\n\ 
          </mirror>\n\ 
        <mirror>\n\ 
           <id>centralInsecure</id>\n\ 
           <name>Central Repository</name>\n\ 
           <url>http://insecure.repo1.maven.org/maven2/</url>\n\ 
           <mirrorOf>central</mirrorOf>\n\ 
        </mirror>\n\ 
   </mirrors>\n\ 
   <profiles>\n\ 
        <profile>\n\ 
           <id>myprofile</id>\n\ 
           <pluginRepositories>\n\ 
              <pluginRepository>\n\ 
                 <releases>\n\ 
                    <updatePolicy>always</updatePolicy>\n\ 
                 </releases>\n\ 
                 <snapshots>\n\ 
                    <updatePolicy>always</updatePolicy>\n\ 
                    <enabled>true</enabled>\n\ 
                 </snapshots>\n\ 
                 <id>central</id>\n\ 
                 <name>Central Repository</name>\n\ 
                 <url>http://192.168.100.123:8081/repository/Central2/</url>\n\ 
              </pluginRepository>\n\ 
           </pluginRepositories>\n\ 
           <repositories>\n\ 
              <repository>\n\ 
                 <id>public</id>\n\ 
                 <name>maven central mirror Repository</name>\n\ 
                 <url>http://192.168.100.123:8081/repository/public/</url>\n\ 
                 <releases>\n\ 
                    <updatePolicy>always</updatePolicy>\n\ 
                    <enabled>true</enabled>\n\ 
                 </releases>\n\ 
                 <snapshots>\n\ 
                    <updatePolicy>always</updatePolicy>\n\ 
                    <enabled>true</enabled>\n\ 
                 </snapshots>\n\ 
              </repository>\n\ 
           </repositories>\n\ 
        </profile>\n\ 
     </profiles>\n\ 
     <activeProfiles>\n\ 
        <activeProfile>myprofile</activeProfile>\n\ 
     </activeProfiles>\n\ 
  </settings>" > settings.xml
#2021.1.4-linux-sudo-3
RUN cd /usr/local/bin; sudo curl -LO https://dl.k8s.io/release/v1.21.4/bin/linux/amd64/kubectl ;sudo chmod +x kubectl ; cd ~ ;curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash 
#2021.1.4-linux-sudo-4
RUN docker login -u 'robot$teamcity' -p "CYUnhdZeCWBuXcGeSBRwiRXPfZIkcylC" 192.168.100.123:10301

USER root
RUN service docker stop