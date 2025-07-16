#!/bin/sh
set +e
SRC_DIRECTORY="$(pwd)"
REPORT_DIRECTORY="$SRC_DIRECTORY/report"

if [ ! -d "$REPORT_DIRECTORY" ]; then
    echo "Initially creating persistent directories"
    mkdir -p "$REPORT_DIRECTORY"
    chmod -R 777 "$REPORT_DIRECTORY"
fi

# Make sure we are using the latest version
docker pull secfigo/bandit:latest

#docker run --rm --privileged \
#  --user 0 \
#  -v /var/lib/jenkins/workspace/sonarscan:/src \
#  -v /var/lib/jenkins/workspace/sonarscan/report:/report \
#  secfigo/bandit:latest

 docker run --rm --privileged --user 0   -v /var/lib/jenkins/workspace/sonarscan:/src   -v /var/lib/jenkins/workspace/sonarscan/report:/report   -v /var/lib/jenkins/workspace/sonarscan/banditParser.py:/bandit/banditParser.py   secfigo/bandit:latest
