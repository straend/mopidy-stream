FROM phusion/baseimage:0.9.11
MAINTAINER Tomas Strand <tomas@fik1.net>

# Orginal maintainer and creator, all credits should go to him
# Christopher Schirner <christopher@hackerspace-bamberg.de>
# I just changed the weblient repo
##########################################################################################
# baseimage specific stuff

ENV HOME /root

##########################################################################################
# disable ssh

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

##########################################################################################
# Prepare ubuntu for apt-add etc

RUN apt-get -qq update
RUN apt-get install -y wget software-properties-common

##########################################################################################
# Install liquidsoap

RUN apt-get install -y liquidsoap

##########################################################################################
# Install mopidy

RUN wget -q -O - http://apt.mopidy.com/mopidy.gpg | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mopidy.list http://apt.mopidy.com/mopidy.list
RUN apt-get -qq update

RUN apt-get install -y mopidy mopidy-spotify mopidy-soundcloud

##########################################################################################

RUN apt-get install -y git
RUN git clone https://github.com/straend/Mopidy-MusicBox-Webclient.git /usr/local/src/mopidy-web
RUN ln -s /usr/local/src/mopidy-web/webclient /etc/mopidy/www

##########################################################################################
# Add configurations

ADD cfg/mopidy.conf /etc/mopidy/mopidy.conf

ADD cfg/mopidy.liq /usr/local/bin/mopidy.liq
RUN chmod +x /usr/local/bin/mopidy.liq

##########################################################################################
# Add init scripts

RUN mkdir /etc/service/00-liquidsoap
ADD run/liquidsoap.sh /etc/service/00-liquidsoap/run
RUN chmod +x /etc/service/00-liquidsoap/run

RUN mkdir /etc/service/01-mopidy
ADD run/mopidy.sh /etc/service/01-mopidy/run
RUN chmod +x /etc/service/01-mopidy/run

##########################################################################################
# Finish container

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 6680
EXPOSE 6600
EXPOSE 8800

CMD ["/sbin/my_init"]
