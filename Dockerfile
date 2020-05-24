# Base image for JDK 8u222 on Debian 10
FROM openjdk:8u222-jdk-slim-buster
ARG SBT_VERSION=1.3.8

# We need wget and ca-certificates to get the .deb
RUN apt-get update
RUN apt-get install wget ca-certificates -y

# Download the deb archive
RUN wget -q https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb -O sbt.deb

# Install it
RUN dpkg -i sbt.deb
RUN rm sbt.deb

# Now install the package from apt
RUN apt-get update
RUN apt-get install sbt -y

# Also install git for dev needs
RUN apt-get install git -y

# Test to make sure it worked, 
# also forcing the download of sbt from the launcher
RUN sbt sbtVersion

# Define a volume for the working directory
VOLUME [ "/workspace" ]
WORKDIR /workspace

# Define sbt as the entrypoint
ENTRYPOINT [ "sbt" ]
