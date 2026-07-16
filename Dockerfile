#############################################################
## Intentionally Vulnerable Dockerfile (TEST ONLY)
#############################################################
#
#FROM ubuntu:18.04
#
#WORKDIR /app
#
## Install packages that are known to have vulnerabilities
#RUN apt-get update && \
#    apt-get install -y \
#        openjdk-8-jre \
#        openssl \
#        curl \
#        wget \
#        bash \
#        vim && \
#    rm -rf /var/lib/apt/lists/*
#
## Copy your application
#COPY target/phegonbank-0.0.1-SNAPSHOT.jar app.jar
#
#EXPOSE 8080
#
#ENTRYPOINT ["java", "-jar", "app.jar"]





############################################################
# Build Stage
############################################################
FROM maven:3.9.11-eclipse-temurin-21 AS builder

WORKDIR /app

COPY pom.xml .

# Cache Maven repository between builds
RUN --mount=type=cache,target=/root/.m2 \
    mvn dependency:go-offline

COPY src ./src

RUN --mount=type=cache,target=/root/.m2 \
    mvn clean package -DskipTests

############################################################
# Runtime Stage
############################################################
FROM gcr.io/distroless/java21-debian12

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
