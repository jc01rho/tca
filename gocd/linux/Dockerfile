FROM sparrow-harbor.fasoo.com:32023/mirror/gocd/gocd-agent-docker-dind:v23.5.0


USER root
RUN apk --no-cache add tzdata && \
	cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
	echo "Asia/Seoul" > /etc/timezone \
	apk del tzdata
# begin - kubectl
RUN apk update && apk add --no-cache --update curl git jq unzip sudo  python3 py3-pip coreutils ca-certificates

RUN curl -LO https://dl.k8s.io/release/v1.25.9/bin/linux/amd64/kubectl ; chmod 777 kubectl && mv kubectl /bin/kubectl
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash  ; 
# end - kubectl

RUN mkdir -p /etc/docker; cd /etc/docker; echo -e '{ \n\ 
        "insecure-registries" : [ "192.168.11.124:8082","192.168.11.124:8099","sparrow-harbor.fasoo.com:32023","io.docker.k8s.sparrow.local" ], \n\
        "registry-mirrors": ["http://io.docker.k8s.sparrow.local"], \n\
        "experimental": true, \n\
        "builder": {"Entitlements": {"security-insecure": true }} \n\
}'  > daemon.json ; cat daemon.json 



RUN cd /usr/local/share/ca-certificates/; \
      curl --insecure -O https://nexus.sparrow.local/repository/sparrow/infra/rootca.crt; \
      update-ca-certificates



ADD config.kube /home/go/.kube/config

ADD --chown=root:root ssh.tar /root/.ssh
ADD ./ssh/id_rsa /root/.ssh/id_rsa
ADD ./ssh/id_rsa.pub /root/.ssh/id_rsa.pub

RUN cd ~ ; docker login -u 'robot$teamcity_agent' -p "ya3Ka8heAZH0nnFhehHD4rndizHjfww8" sparrow-harbor.fasoo.com:32023 ;helm repo add sparrow-infra http://sparrow-nexus.fasoo.com:8081/repository/sparrow-helm/ --username admin --password 1234 ; helm repo update

USER go
RUN cd ~ ; docker login -u 'robot$teamcity_agent' -p "ya3Ka8heAZH0nnFhehHD4rndizHjfww8" sparrow-harbor.fasoo.com:32023 ;helm repo add sparrow-infra http://sparrow-nexus.fasoo.com:8081/repository/sparrow-helm/ --username admin --password 1234 ; helm repo update
# ADD config ~/.kube/config
ADD config.kube /home/go/.kube/config

ADD --chown=go:root ssh.tar /home/go/.ssh
ADD ./ssh/id_rsa /home/go/.ssh/id_rsa
ADD ./ssh/id_rsa.pub /home/go/.ssh/id_rsa.pub


USER root
# RUN chmod 700 ~/.kube/config
RUN chmod 700 /home/go/.kube/config
RUN chown -R go /home/go/.kube
USER go