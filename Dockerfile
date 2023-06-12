FROM openjdk:8

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git jq

RUN wget https://downloads.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz && \
    HASH=900bdeeeae550d2d2b3920fe0e00e41b0069f32c019d566465015bdd1b3866395cbe016e22d95d25d51d3a5e614af2c83ec9b282d73309f644859bbad08b63db && \
    echo "$HASH apache-maven-3.9.2-bin.tar.gz" | sha512sum --check --status && \
    tar xf apache-maven-3.9.2-bin.tar.gz -C /opt

ENV M2_HOME="/opt/apache-maven-3.9.2"
ENV MAVEN_HOME="/opt/apache-maven-3.9.2"
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

RUN mvn -version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
