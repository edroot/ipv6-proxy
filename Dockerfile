FROM debian:jessie
RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list \
    && apt-get update \
    && apt-get -y install gcc++ git make screen mc wget \
    && apt-get -y -t jessie-backports --yes --force-yes install linux-image-amd64
RUN cd ~ && git clone https://anonscm.debian.org/cgit/collab-maint/ndppd.git \
    && cd ~/ndppd && make all && make install \
    && cd ~ && git clone https://github.com/z3APA3A/3proxy.git \
    && cd 3proxy/ && make -f Makefile.Linux

CMD ["/bin/sh", "/init.sh"]