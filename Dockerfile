# docker rm -f tor; docker build -t myproxy . && docker run -d -p 8118:8118 --name tor -i myproxy && chromium-browser --proxy-server='http://127.0.0.1:8118'
# docker exec -ti tor supervisorctl restart tor
# identiguy.i2p
# 127.0.0.1:4444
# другая форма цмд, удалить конфиги тора, написать то что выше в ридми и залить на гитхаб

FROM ubuntu:16.04

RUN apt-get update                                 && \
    apt-get -y install software-properties-common  && \
    add-apt-repository -y ppa:purplei2p/i2pd       && \
    apt-get update                                 && \
	apt-get install -y privoxy tor i2pd supervisor && \
	apt-get clean autoclean                        && \
	apt-get autoremove -y                          && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/* /tmp/* /var/tmp/*  &&\
	mkdir -p /opt/supervisor/conf.d /opt/privoxy /opt/tor

COPY configs /opt/

EXPOSE 8118

CMD supervisord -c /opt/supervisor/supervisord.conf
