# Base image for JDK 8u222 on Debian 10
FROM openjdk:8u292-jdk-slim-buster
ARG SBT_VERSION=1.5.0

# We need wget and ca-certificates to get the .deb
RUN apt-get update
RUN apt-get install wget ca-certificates -y

# Download the release archive
RUN mkdir -p /sbt
WORKDIR /sbt
RUN wget -q https://github.com/sbt/sbt/releases/download/v1.5.3/sbt-1.5.3.tgz -O sbt.tgz

# Unpack it
RUN tar -xzvf sbt.tgz
RUN rm sbt.tgz

# Test to make sure it worked, 
# also forcing the download of sbt from the launcher
RUN ln -s /sbt/bin/sbt /bin/sbt
RUN sbt sbtVersion

# Define a volume for the working directory
VOLUME [ "/workspace" ]
WORKDIR /workspace

# Define sbt as the entrypoint
ENTRYPOINT [ "sbt" ]
