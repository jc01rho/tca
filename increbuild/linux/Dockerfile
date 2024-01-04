
FROM sparrow-harbor.fasoo.com:32023/mirror/jetbrains/teamcity-agent:2021.2.3-linux-sudo



USER root
ARG DEBIAN_FRONTEND=noninteractive
RUN echo "Acquire::http::Pipeline-Depth 0;"   >>/etc/apt/apt.conf.d/99fixbadproxy
RUN echo "Acquire::http::No-Cache true;"   >>/etc/apt/apt.conf.d/99fixbadproxy
RUN echo "Acquire::BrokenProxy    true;"   >>/etc/apt/apt.conf.d/99fixbadproxy
RUN sed -i 's#archive.ubuntu.com#sparrow-nexus.fasoo.com:8081/repository/apt#g' /etc/apt/sources.list
RUN sed -i 's#mirror.ubuntu.com#sparrow-nexus.fasoo.com:8081/repository/apt#g' /etc/apt/sources.list
RUN sed -i 's#security.ubuntu.com#sparrow-nexus.fasoo.com:8081/repository/apt#g' /etc/apt/sources.list
ARG DEBCONF_NOWARNINGS="yes"
ENV DOCKER_CLI_EXPERIMENTAL=enabled
ENV DOCKER_BUILDKIT=0
ENV TZ=Asia/Seoul

RUN  sed -i '50,51d' /etc/apt/sources.list ; rm -rf /etc/apt/sources.list.d/perforce.list /etc/apt/sources.list.d/docker.list ; apt-get remove docker docker-engine docker.io containerd runc && echo "update" ;  apt-get update  ; echo" install" ; apt-get install  --no-install-recommends  --no-install-suggests -y ca-certificates curl gnupg apt-utils aptitude &&  apt-get install  --no-install-recommends  --no-install-suggests -y  software-properties-common curl lsb-release &&  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    mkdir -m 0755 -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && curl -fsSL  https://package.perforce.com/perforce.pubkey | gpg --dearmor -o /etc/apt/keyrings/perforce.gpg &&  \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
   echo "deb [signed-by=/etc/apt/keyrings/perforce.gpg] https://package.perforce.com/apt/ubuntu $(lsb_release -cs) release" | tee /etc/apt/sources.list.d/perforce.list > /dev/null && \
    echo "install docker-ce docker-ce-cli containerd.io docker-compose-plugin" && \
    chmod a+r /etc/apt/keyrings/docker.gpg && apt-get update && apt-get install  --no-install-recommends  --no-install-suggests  -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin aufs-tools cgroupfs-mount cgroup-lite && \
    curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb && \
    echo "install ./zulu-repo_1.0.0-3_all.deb" && \
    apt-get install  --no-install-recommends  --no-install-suggests  -y ./zulu-repo_1.0.0-3_all.deb && \
    rm ./zulu-repo_1.0.0-3_all.deb && \
   #  apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main' && \
    apt-get update && \
    echo "install zulu8-ca zulu13-ca zip unzip git openssh-client jq tzdata bash  python3 python3-pip python3-dev" && \
    apt-get install  --no-install-recommends  --no-install-suggests  -y wget zulu8-ca zulu11-ca zulu13-ca zip unzip git openssh-client jq tzdata bash  python3 python3-pip python3-dev binutils keychain binfmt-support build-essential; apt-get install  --no-install-recommends  --no-install-suggests  -y zulu17-ca zulu19-ca; \
    cd /usr/local/bin && \
    ln -s /usr/bin/python3 python && \
    pip3 install --upgrade pip setuptools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/apt/lists/*
    # https://github.com/goodwithtech/dockle/blob/master/CHECKPOINT.md#dkl-di-0005

# RUN bash -c 'echo "DOCKER_OPTS=\"--insecure-registry 192.168.11.124:8082 --insecure-registry 192.168.11.124:8099  --insecure-registry sparrow-harbor.fasoo.com:32023 \"" >> /etc/default/docker'

RUN mkdir -p /etc/docker; cd /etc/docker; echo ' {\n\ 
        "insecure-registries" : [ "192.168.11.124:8082","192.168.11.124:8099","sparrow-harbor.fasoo.com:32023" ], \n\
        "registry-mirrors": ["http://sparrow-harbor.fasoo.com:30780","https://mirror.gcr.io"], \n\
        "experimental": true, \n\
        "builder": {"Entitlements": {"security-insecure": true }}, \n\
        "cgroup-parent": "docker.slice", \n\
        "features": { "buildkit": true } \n\
         \n\
}'  > daemon.json


RUN git config --global core.symlinks false ; chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo; chown root:root /usr/lib/sudo/sudoers.so; chown root:root /etc/sudoers; exit 0

USER buildagent
# RUN sed -i "s#FJ_MIN_UNSUPPORTED_JAVA_VERSION=12#FJ_MIN_UNSUPPORTED_JAVA_VERSION=18#g" /opt/buildagent/bin/agent.sh

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
RUN cd /usr/local/bin; sudo curl -LO https://dl.k8s.io/release/v1.21.4/bin/linux/amd64/kubectl ;sudo chmod +x kubectl ; cd ~ ;curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash ; helm plugin install https://github.com/chartmuseum/helm-push  ; helm repo add sparrow-infra http://sparrow-nexus.fasoo.com:8081/repository/sparrow-helm/ --username admin --password 1234
#2021.1.4-linux-sudo-4
#RUN docker login -u 'robot$teamcity' -p "CYUnhdZeCWBuXcGeSBRwiRXPfZIkcylC" sparrow-harbor.fasoo.com:32023


ADD config.kube /home/buildagent/.kube/config
RUN ls ~/.kube ; ls /home/buildagent/.kube ; sudo chown -R buildagent /home/buildagent/.kube; sudo chmod -R 700 /home/buildagent/.kube/

# AWS CLI 설치
RUN cd ~ ; curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; unzip awscliv2.zip; sudo ./aws/install --update ; rm -rf awscliv2.zip;

# Terraform 설치 스크립트
  # Terraform 다운로드 및 압축 해제
  # 실행 가능한 파일로 이동
  # 설치된 Terraform 버전 확인
RUN TERRAFORM_VERSION="1.6.4"; TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"; cd ~ ; curl -O ${TERRAFORM_URL}; unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip; sudo mv terraform /usr/local/bin/; terraform version ; rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip;

# JQ 설치 - 상위 라인32 에서 이미 해결됨
# RUN sudo apt-get update; sudo apt-get install jq

RUN mkdir ~/.docker; cd ~/.docker; echo ' {\n\ 
        "auths": {\n\ 
                "sparrow-harbor.fasoo.com:32023": { \n\
                        "auth": "YWRtaW46MTIzNA==" \n\
                }, \n\
                "http://sparrow-harbor.fasoo.com:32023": { \n\
                        "auth": "YWRtaW46MTIzNA==" \n\
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

# RUN git config --global --add safe.directory /opt/buildagent/work
RUN git config --global --add safe.directory '*'
RUN git config --system --add safe.directory '*'

