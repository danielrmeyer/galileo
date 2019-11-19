# Start from openjdk and name this stage 'build'
FROM openjdk:8 AS build

ENV SBT_VERSION 1.3.3

RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

WORKDIR /galileo

ADD . /galileo

# This works inside the docker image; not locally (at least not for me)
RUN sbt assembly


FROM openjdk:8
COPY --from=build \
    /galileo/target/scala-2.13/Galileo-assembly-0.1.3.jar galileo.jar

CMD [ "java", "-jar", "galileo.jar" ]


