FROM debian:11-slim

ENV DEBIAN_FRONTEND noninteractive

ARG VERSION_1C
ARG HASP_IP

ENV USER=root
ENV usr_uid=999
ENV usr_gid=999

RUN apt-get update && apt-get install supervisor imagemagick gosu ca-certificates sudo liblcms2-2 fontconfig locales --yes --no-install-recommends \
    && gosu nobody true

RUN localedef --inputfile ru_RU --force --charmap UTF-8 --alias-file /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG=ru_RU.utf8

ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD dist/deb64*.tar.gz /tmp
RUN ls -lh /tmp; echo $
RUN set -xe \
    && dpkg -i /tmp/*common_*.deb \
    && dpkg -i /tmp/*server_*.deb \
    && rm -rf /tmp/*

RUN groupmod -g $usr_uid grp1cv8 \
    && usermod -u $usr_gid usr1cv8 \
    && mkdir -p /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf /home/usr1cv8/sync1c \
    && chown -R usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8 /home/usr1cv8/sync1c

VOLUME /home/usr1cv8/.1cv8
VOLUME /var/log/1C
VOLUME /home/usr1cv8/sync1c

COPY server/container/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY server/container/docker-entrypoint.sh /
COPY server/container/run1c.sh /
COPY server/container/logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf
COPY server/container/nethasp.ini /opt/1cv8/conf/nethasp.ini

RUN chmod +x /docker-entrypoint.sh /run1c.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 1540-1541 1560-1591
