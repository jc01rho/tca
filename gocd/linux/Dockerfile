FROM sparrow-harbor.fasoo.com:32023/mirror/gocd/gocd-agent-docker-dind:v23.2.0


USER root
RUN apk --no-cache add tzdata && \
	cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
	echo "Asia/Seoul" > /etc/timezone \
	apk del tzdata
# begin - kubectl
RUN apk update && apk add --no-cache --update curl git jq unzip sudo  python3 py3-pip coreutils

RUN curl -LO https://dl.k8s.io/release/v1.21.4/bin/linux/amd64/kubectl ; chmod 777 kubectl && mv kubectl /bin/kubectl
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash  ; 
# end - kubectl

RUN mkdir -p /etc/docker; cd /etc/docker; echo ' {\n\ 
        "insecure-registries" : [ "192.168.11.124:8082","192.168.11.124:8099","sparrow-harbor.fasoo.com:32023" ], \n\
        "registry-mirrors": ["http://sparrow-harbor.fasoo.com:30780","https://mirror.gcr.io"], \n\
        "experimental": true, \n\
        "builder": {"Entitlements": {"security-insecure": true }} \n\
         \n\
}'  > daemon.json



USER go
RUN cd ~ ; docker login -u 'robot$teamcity_agent' -p "ya3Ka8heAZH0nnFhehHD4rndizHjfww8" sparrow-harbor.fasoo.com:32023 ;helm repo add sparrow-infra http://sparrow-nexus.fasoo.com:8081/repository/sparrow-helm/ --username admin --password 1234
# ADD config ~/.kube/config
ADD config /home/go/.kube/config
USER root
# RUN chmod 700 ~/.kube/config
RUN chmod 700 /home/go/.kube/config
RUN chown -R go /home/go/.kube
USER go