FROM debian:jessie

MAINTAINER Andrew Tan<andrew@switch168.com>

RUN sed -i 's/httpredir/ftp.us/g' /etc/apt/sources.list
RUN rm -rf /var/lib/apt/lists/* && apt-get update 

# RTPengine 59a69f0

RUN apt-get -y install debhelper iptables-dev libevent-dev libglib2.0-dev libhiredis-dev libpcap0.8.dev libxmlrpc-core-c3-dev markdown dpkg git libcurl4-openssl-dev libssl-dev dkms module-assistant 

RUN git clone https://github.com/sipwise/rtpengine.git && cd rtpengine && git checkout 59a69f0

RUN cd rtpengine && ./debian/flavors/no_ngcp && dpkg-buildpackage
RUN dpkg -i *daemon*.deb
RUN dpkg -i *iptables*.deb
RUN dpkg -i *kernel*.deb



CMD /bin/sh -c "while true; do echo hello world; sleep 1; done" 



