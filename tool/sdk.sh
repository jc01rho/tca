#!/bin/bash
#-H localhost:2375
docker run -i --rm -w="/teamcity" -v "$(pwd):/teamcity" mcr.microsoft.com/dotnet/sdk:5.0 $@
