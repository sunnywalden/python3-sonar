FROM sunnywalden/centos7-python3.7:latest

MAINTAINER sunnywalden@gmail.com

USER root

ENV SONAR_URL=$SONAR_URL \
    SONAR_PRO=$SONAR_PRO \
    SONAR_TOKEN=$SONAR_TOKEN

RUN curl https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip -O /opt/sonar-scanner-cli-4.2.0.1873-linux.zip && \
    unzip /opt/sonar-scanner-cli-4.2.0.1873-linux.zip && \
    export PATH=/opt/sonar-scanner-cli-4.2.0.1873-linux/bin:$PATH && \
    rm -rf /opt/sonar-scanner-cli-4.2.0.1873-linux.zip

MAINTAINER sonar-scanner \
      -Dsonar.projectKey=$SONAR_PRO \
      -Dsonar.sources=. \
      -Dsonar.host.url=$SONAR_URL \
      -Dsonar.login=$SONAR_TOKEN
