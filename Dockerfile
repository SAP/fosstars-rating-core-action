FROM openjdk:8

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git jq

RUN wget https://downloads.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz && \
    HASH=f7296534ce624f688268e55544ffdf0b37562ac71dbcede4fe4f994b4e9487b7d66934849204373e127cfacc709cd5fd9152a53c06d778fc391aee84aa3364a3 && \
    echo "$HASH apache-maven-3.9.2-bin.tar.gz" | sha512sum --check --status && \
    tar xf apache-maven-3.9.2-bin.tar.gz -C /opt

ENV M2_HOME="/opt/apache-maven-3.9.2"
ENV MAVEN_HOME="/opt/apache-maven-3.9.2"
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

RUN mvn -version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
