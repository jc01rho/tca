FROM 192.168.100.123:10301/mirror/jetbrains/teamcity-agent:2021.2-linux-sudo

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    # https://github.com/goodwithtech/dockle/blob/master/CHECKPOINT.md#dkl-di-0005
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/apt/lists/*

USER buildagent