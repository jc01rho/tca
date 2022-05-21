FROM sparrow-harbor.fasoo.com:32023/mirror/gocd/gocd-agent-docker-dind:v22.1.0


USER root
RUN apk --no-cache add tzdata && \
	cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
	echo "Asia/Seoul" > /etc/timezone \
	apk del tzdata
# begin - kubectl
RUN apk update && apk add curl git jq unzip sudo
RUN curl -LO https://dl.k8s.io/release/v1.21.4/bin/linux/amd64/kubectl ; chmod 777 kubectl && mv kubectl /bin/kubectl
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash  ; 
# end - kubectl


USER go
RUN cd ~ ; docker login -u 'robot$teamcity_agent' -p "ya3Ka8heAZH0nnFhehHD4rndizHjfww8" sparrow-harbor.fasoo.com:32023 ;helm repo add sparrow-infra http://sparrow-harbor.fasoo.com:32023/chartrepo/infra
# ADD config ~/.kube/config
ADD config /home/go/.kube/config
USER root
# RUN chmod 700 ~/.kube/config
RUN chmod 700 /home/go/.kube/config
RUN chown -R go /home/go/.kube
USER go