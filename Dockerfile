#
# Openhab Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV OPENHAB_VERSION 2.4.0
ENV OPENHAB_HOME /usr/share/openhab2
ENV OPENHAB_CONF /etc/openhab2
ENV OPENHAB_RUNTIME /usr/share/openhab2/runtime
ENV OPENHAB_USERDATA /var/lib/openhab2
ENV OPENHAB_LOGDIR /var/log/openhab2
ENV OPENHAB_STARTMODE daemon


# Update & install packages
RUN apt-get update && \
#    apt-get install -y python3-dev wget git libssl-dev build-essential libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev curl libcurl4-openssl-dev libusb-dev zlib1g-dev 
    apt-get install -y openjdk-8-jre wget apt-transport-https gnupg2

RUN wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | apt-key add - && \
    echo 'deb https://dl.bintray.com/openhab/apt-repo2 stable main' | tee /etc/apt/sources.list.d/openhab2.list && \
    apt-get update && \
    apt-get install -y openhab2 openhab2-addons

## Fetch cmake up to date version
#RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.4/cmake-3.14.4-Linux-x86_64.sh && \
#    bash cmake-3.14.4-Linux-x86_64.sh --skip-license
## Download & deploy domoticz
#RUN git clone --branch ${OPENHAB_VERSION} https://github.com/domoticz/domoticz.git && \
#    cd domoticz && \
#    cmake -DCMAKE_BUILD_TYPE=Release CMakeLists.txt -DUSE_OPENSSL_STATIC="NO" && \
#    make -j 3
#
#EXPOSE 8080
#
#CMD ["/domoticz/domoticz", "-www 8080"]
#CMD ["/usr/share/openhab2/runtime/bin/karaf", "$OPENHAB_STARTMODE"]
CMD ["/usr/share/openhab2/runtime/bin/karaf", "daemon"]
