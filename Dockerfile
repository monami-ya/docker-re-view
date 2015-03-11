FROM ubuntu:14.10

MAINTAINER Masaki Muranaka <monaka@monami-ya.com>

RUN apt-get update
RUN apt-get install -y texlive texlive-lang-cjk
RUN apt-get install -y bundler
RUN apt-get install -y zip
RUN apt-get clean -y

RUN adduser --disabled-password -home /home/dummy --gecos "" dummy
RUN echo "dummy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ADD Gemfile /home/dummy/Gemfile
ADD cacert.pem /home/dummy/cacert.pem
RUN su dummy -c 'cd /home/dummy; SSL_CERT_FILE=/home/dummy/cacert.pem bundle install'
RUN deluser --remove-all-files --remove-home dummy
RUN rm -fr /home/dummy

VOLUME /review

ADD run.sh /run.sh
CMD "/run.sh"
