#
# Build Stage
#
FROM maven:3-jdk-8-alpine as build

RUN mkdir /build
COPY pom.xml /build/
COPY distro /build/distro/
COPY src /build/src

RUN cd /build && \
    mvn -DskipTests=true install

#
# Runtime Stage
#
FROM openjdk:8-jre

EXPOSE 5005 8080
ENV DEBUG_PORT=5005 HTTPS_PORT=8443 HTTP_PORT=8080 JAVA_VENDOR="openjdk"
ENV APP_DIR=/opt/smartenergy APP_USER=user APP_USER_ID=1000

# Create User
RUN adduser -u ${APP_USER_ID} --disabled-password --gecos '' --home ${APP_DIR} ${APP_USER} &&\
    groupadd -g 14 uucp2 &&\
    groupadd -g 16 dialout2 &&\
    groupadd -g 18 dialout3 &&\
    groupadd -g 32 uucp3 &&\
    groupadd -g 997 gpio &&\
    adduser ${APP_USER} dialout &&\
    adduser ${APP_USER} uucp &&\
    adduser ${APP_USER} uucp2 &&\
    adduser ${APP_USER} dialout2 &&\
    adduser ${APP_USER} dialout3 &&\
    adduser ${APP_USER} uucp3 &&\
    adduser ${APP_USER} gpio


WORKDIR ${APP_DIR}

COPY --from=build /build/target/smartenergy-0.9.0-SNAPSHOT ${APP_DIR}

RUN chown -R ${APP_USER}:${APP_USER} ${APP_DIR}

USER ${APP_USER}
CMD ["/opt/smartenergy/start_debug.sh"]
