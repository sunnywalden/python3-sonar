FROM sunnywalden/centos7-python3.7:latest

MAINTAINER sunnywalden@gmail.com

USER root

ENV sonar_version=4.2.0.1873

COPY tmp/sonar-scanner-cli-${sonar_version}-linux.zip /opt/

WORKDIR /opt/

ENV sonar_download_url=https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${sonar_version}-linux.zip \
    sonar_file_path=/tmp/sonar-scanner-cli-${sonar_version}-linux.zip \
    SONAR_URL=${SONAR_URL} \
    SONAR_PRO=${SONAR_PRO} \
    SONAR_TOKEN=${SONAR_TOKEN}

RUN yum -y install unzip && \
    ls -la sonar-scanner* && \
    unzip sonar-scanner-cli-${sonar_version}-linux.zip && \
    export PATH=/opt/sonar-scanner-cli-${sonar_version}-linux/bin:$PATH && \
    rm -rf sonar-scanner-cli-${sonar_version}-linux.zip

ENTRYPOINT sonar-scanner \
      -Dsonar.projectKey=$SONAR_PRO \
      -Dsonar.sources=. \
      -Dsonar.host.url=$SONAR_URL \
      -Dsonar.login=$SONAR_TOKEN
