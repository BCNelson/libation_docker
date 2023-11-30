# Dockerfile to run OpenAudible desktop application from a browser.
# docker build -t openaudible .
# docker run -d --rm -it -v $HOME/OpenAudible:/config/OpenAudible -p 3000:3000 --name openaudible openaudible

FROM ghcr.io/linuxserver/webtop:ubuntu-xfce

EXPOSE 3000

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libgtk-3-bin ca-certificates wget libswt-webkit-gtk-4-jni vim xdg-utils libnss3-dev 
RUN apt remove -y xfce4-panel firefox

VOLUME /config/OpenAudible
COPY setup.sh /config/setup.sh

# Make sure file encoding will be set to UTF-8. 
COPY --from=debian:9.11 /usr/lib/locale /usr/lib/locale

# copy slightly modified startvm.sh to defaults to start OpenAudible
# This gets executed when a web browser hits the http://localhost:3000 page
COPY startwm.sh /defaults/startwm.sh
