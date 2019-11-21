FROM circleci/python:ubuntu:3.7.5-stretch
RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install -y software-properties-common
RUN apt-get install -y wget gnupg python3-dev python3-venv python3.7-dev python3.7-venv curl git ssh tar gzip ca-certificates
RUN curl https://bootstrap.pypa.io/get-pip.py | python3
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | tee /etc/apt/sources.list.d/postgresql.list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential yarn postgresql-10 redis-server
RUN apt-get install -y binutils libproj-dev gdal-bin postgresql-10-postgis-scripts
COPY --chown=postgres:postgres  pg_hba.conf /etc/postgresql/10/main
RUN chmod 644 /etc/postgresql/10/main/pg_hba.conf
COPY --chown=redis:redis  redis.conf /etc/redis/
RUN chmod 640 /etc/redis/redis.conf
