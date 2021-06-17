FROM ubuntu:20.04 as build

RUN apt update && apt install -y curl gnupg openjdk-13-jdk && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add && \
    apt update && apt install -y sbt

WORKDIR /build/
COPY . /build/
RUN sbt assembly

FROM openjdk:11-jre-slim-buster

WORKDIR /app/
COPY --from=build /build/target/scala-2.13/status-assembly-0.1.jar ./
COPY --from=build /build/src/main/webapp/ ./src/main/webapp/

COPY config-template.yml ./config.yml
COPY entrypoint.sh ./entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
EXPOSE 8080
