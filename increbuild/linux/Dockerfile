FROM sparrow-harbor.fasoo.com:32023/mirror/jetbrains/teamcity-agent:2021.2.3-linux-sudo


ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
USER root


RUN apt-get update && apt-get install -y software-properties-common gnupg curl lsb-release && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && \
    curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb && \
    apt-get install ./zulu-repo_1.0.0-3_all.deb && \
    rm ./zulu-repo_1.0.0-3_all.deb && \
   #  apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main' && \
    apt-get update && \
    apt-get install -y wget zulu8-ca zulu13-ca zip unzip git openssh-client jq tzdata bash  python3 python3-pip python3-dev ; apt-get install -y zulu17-ca ; \
    cd /usr/local/bin && \
    ln -s /usr/bin/python3 python && \
    pip3 install --upgrade pip setuptools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/apt/lists/*
    # https://github.com/goodwithtech/dockle/blob/master/CHECKPOINT.md#dkl-di-0005

# RUN bash -c 'echo "DOCKER_OPTS=\"--insecure-registry 192.168.11.124:8082 --insecure-registry 192.168.11.124:8099  --insecure-registry sparrow-harbor.fasoo.com:32023 \"" >> /etc/default/docker'

RUN mkdir -p /etc/docker; cd /etc/docker; echo ' {\n\ 
        "insecure-registries" : [ "192.168.11.124:8082","192.168.11.124:8099","sparrow-harbor.fasoo.com:32023" ],\n\
        "builder": {"Entitlements": {"security-insecure": true }} \n\
         \n\
}'  > daemon.json


RUN git config --global core.symlinks false ; chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo; chown root:root /usr/lib/sudo/sudoers.so; chown root:root /etc/sudoers; exit 0

USER buildagent

RUN git config --global core.symlinks false ; mkdir ~/.m2; cd ~/.m2; echo '<?xml version="1.0" encoding="UTF-8"?>\n\ 
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
  </settings>' > settings.xml
#2021.1.4-linux-sudo-3
RUN cd /usr/local/bin; sudo curl -LO https://dl.k8s.io/release/v1.21.4/bin/linux/amd64/kubectl ;sudo chmod +x kubectl ; cd ~ ;curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash ; helm plugin install https://github.com/chartmuseum/helm-push  ; helm repo add sparrow-infra http://sparrow-harbor.fasoo.com:32023/chartrepo/infra
#2021.1.4-linux-sudo-4
#RUN docker login -u 'robot$teamcity' -p "CYUnhdZeCWBuXcGeSBRwiRXPfZIkcylC" sparrow-harbor.fasoo.com:32023

RUN mkdir ~/.docker; cd ~/.docker; echo ' {\n\ 
        "auths": {\n\ 
                "sparrow-harbor.fasoo.com:32023": { \n\
                        "auth": "cm9ib3QkdGVhbWNpdHlfYWdlbnQ6eWEzS2E4aGVBWkgwbm5GaGVoSEQ0cm5kaXpIamZ3dzg=" \n\
                }, \n\
                "http://sparrow-harbor.fasoo.com:32023": { \n\
                        "auth": "cm9ib3QkdGVhbWNpdHlfYWdlbnQ6eWEzS2E4aGVBWkgwbm5GaGVoSEQ0cm5kaXpIamZ3dzg=" \n\
                }, \n\
                "192.168.11.124:8099": {\n\ 
                        "auth": "c2FzdDpzYXN0"\n\ 
                },\n\ 
                "https://index.docker.io/v1/": {\n\ 
                        "auth": "c3BhcnJvd3Nhc3Q6YTEyMzQ1Njc4IQ=="\n\ 
                }\n\ 
        }\n\ 
}'  > config.json

RUN mkdir ~/.ssh; cd ~/.ssh; echo 'KexAlgorithms +diffie-hellman-group1-sha1\n\n\
Host *\n\
    StrictHostKeyChecking no' > config
ADD --chown=buildagent:buildagent ssh.tar /home/buildagent/.ssh


