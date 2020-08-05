
FROM ubuntu:18.04

MAINTAINER Husni

RUN apt update && apt upgrade -y && apt install -y dnsutils curl openjdk-8-jre

RUN curl ifconfig.me > tmp_ip

ARG JAR_FILE=build/libs/*.jar

COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]

HEALTHCHECK --interval=5s --timeout=3s CMD curl $(cat tmp_ip):2020
