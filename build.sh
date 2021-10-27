

# wget -c https://download.jetbrains.com/teamcity/TeamCity-$1.tar.gz
# tar -zxvf TeamCity-$1.tar.gz -C context

# chmod +x ./generate.sh
# chmod +x ./context.sh
# ./generate.sh
# ./context.sh

# docker pull ubuntu:20.04
# echo TeamCity/webapps > context/.dockerignore
# echo TeamCity/devPackage >> context/.dockerignore
# echo TeamCity/lib >> context/.dockerignore
# docker build -f "generated/linux/MinimalAgent/Ubuntu/20.04/Dockerfile" -t teamcity-minimal-agent:local-linux "context"
# echo 2> context/.dockerignore
# echo TeamCity >> context/.dockerignore
# docker build -f "generated/linux/Agent/Ubuntu/20.04/Dockerfile" -t teamcity-agent:local-linux "context"
# docker build -f "generated/linux/Agent/Ubuntu/20.04-sudo/Dockerfile" -t 192.168.100.123:10301/infra/teamcity-agent:%arg1%-linux-sudo-sparrow-1  -t 192.168.100.123:10301/infra/teamcity-agent:latest "context"


#2021.2
docker build -f increbuild/linux/Dockerfile -t 192.168.100.123:10301/infra/teamcity-agent:2021.2-linux-sudo-sparrow-1  -t 192.168.100.123:10301/infra/teamcity-agent:latest


docker login -u admin -p 1234 192.168.100.123:10301
docker push 192.168.100.123:10301/infra/teamcity-agent:2021.2-linux-sudo-sparrow-1
docker push 192.168.100.123:10301/infra/teamcity-agent:latest


