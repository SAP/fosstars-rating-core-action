FROM maven:3.9.2-eclipse-temurin-8

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git jq

RUN mvn -version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
