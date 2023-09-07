FROM debian:11-slim

ENV DEBIAN_FRONTEND noninteractive

ENV PGDATA=/data
ARG PGPASSWORD

ENV usr_uid=999
ENV usr_gid=999

RUN apt-get update && apt-get install supervisor wget locales ca-certificates --yes --no-install-recommends

RUN localedef --inputfile ru_RU --force --charmap UTF-8 --alias-file /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG=ru_RU.utf8

ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN wget https://repo.postgrespro.ru/1c-15/keys/pgpro-repo-add.sh \
    && sh pgpro-repo-add.sh \
    && apt-get install postgrespro-1c-15 --yes --no-install-recommends

RUN groupmod -g $usr_uid postgres \
    && usermod -u $usr_gid postgres \
    && mkdir $PGDATA /var/log/postgres \
    && chown -R postgres:postgres $PGDATA /var/log/postgres

VOLUME $PGDATA
VOLUME /var/log/postgres

COPY db/container/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY db/container/docker-entrypoint.sh /
COPY db/container/runpg.sh /

RUN chmod +x /docker-entrypoint.sh /runpg.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432