FROM openjdk:8
ARG SBT_VERSION=1.5.0

# Download the release archive
RUN wget -q https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz -O sbt.tgz

# Unpack it
RUN mkdir -p /sbt
RUN tar -xzvf sbt.tgz -C /sbt --strip-components=1
RUN rm sbt.tgz

# Define a volume for the working directory
VOLUME [ "/workspace" ]
WORKDIR /workspace

# Test to make sure setup worked, 
# also forcing the download of sbt from the launcher
RUN ln -s /sbt/bin/sbt /bin/sbt
RUN sbt sbtVersion

# Define sbt as the entrypoint
ENTRYPOINT [ "sbt" ]
