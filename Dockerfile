FROM rocker/rstudio:latest
MAINTAINER Joerg Lenhard <joerg.lenhard@kau.se>
	
COPY /classifiers.R /home/rstudio/saerocon2017-replication/	
COPY /data-frame.csv /home/rstudio/saerocon2017-replication/	
	
# Install dependenceis for getting Weka to work with R
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite-dev \
  libmariadbd-dev \
  libmariadb-client-lgpl-dev \
  libpq-dev \
  libicu-dev \
  libbz2-dev \
  liblzma-dev \
  default-jdk \
  && R CMD javareconf \
  && . /etc/environment \