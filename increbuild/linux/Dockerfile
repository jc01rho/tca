FROM 192.168.100.123:10301/mirror/jetbrains/teamcity-agent:2021.2-linux-sudo

USER root
COPY settings.xml /tmp/settings.xml
RUN service docker start
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    # https://github.com/goodwithtech/dockle/blob/master/CHECKPOINT.md#dkl-di-0005
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/apt/lists/*

RUN bash -c 'echo "DOCKER_OPTS=\"--insecure-registry 192.168.11.124:8082 --insecure-registry 192.168.11.124:8099  --insecure-registry 192.168.100.123:10301 \"" >> /etc/default/docker'


USER buildagent
RUN mkdir ~/.m2; cd ~/.m2; mv /tmp/settings.xml .
#2021.1.4-linux-sudo-3
RUN cd /usr/local/bin; sudo curl -LO https://dl.k8s.io/release/v1.21.4/bin/linux/amd64/kubectl ;sudo chmod +x kubectl ; cd ~ ;curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash 
#2021.1.4-linux-sudo-4
RUN docker login -u 'robot$teamcity' -p "CYUnhdZeCWBuXcGeSBRwiRXPfZIkcylC" 192.168.100.123:10301

USER root
RUN service docker stop