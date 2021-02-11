FROM openjdk:8

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git maven jq

RUN mkdir -p /opt/stuff && cd /opt/stuff && \
    git clone https://github.com/SAP/fosstars-rating-core && \
    cd fosstars-rating-core && \
    git checkout $INPUT_FOSSTARS-VERSION && \
    mvn package -DskipTests

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
