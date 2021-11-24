FROM ubuntu:focal

ENV branch=ubuntu
ENV distro=focal

ENV TZ=America/Chicago

WORKDIR /opt
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y wget procps gpg libcurl4

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x7E148E3C && \
    echo "deb https://repo.z-wave.me/z-way/$branch $distro main" > /etc/apt/sources.list.d/z-wave-me.list

RUN apt-get update && \
    apt-get install -y libmosquitto1 z-way-server && \
    apt-get clean

COPY ./MQTTClient /opt/z-way-server/automation/modules/

ENV LD_LIBRARY_PATH=/opt/z-way-server/libs
ENV PATH=/opt/z-way-server:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

VOLUME ["/opt/z-way-server/config"]
VOLUME ["/opt/z-way-server/automation/storage"]
VOLUME ["/opt/z-way-server/automation/userModules"]

EXPOSE 8083

CMD /etc/init.d/z-way-server start && tail -f /var/log/z-way-server.log 
