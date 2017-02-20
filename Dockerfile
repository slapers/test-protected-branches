FROM debian:jessie

MAINTAINER stefan.lapers@intersoft.solutions

# See https://github.com/mark-adams/docker-chromium-xvfb
# on running chrome in docker

RUN set -ex \
  && echo " ------ GETTING DEPENDENCIES ------" \
  && apt-get update \
  && apt-get install -y xvfb chromium \
  && echo " ------ SETTING UP NODEJS ------" \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install -y nodejs git && npm install -g npm@latest \
  && echo " ------ SETTING UP ANGULAR CLI ------" \
  && npm install -g @angular/cli@latest

ADD docker/xvfb-chromium /usr/bin/xvfb-chromium
RUN set -ex \
  && ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome \
  && ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser \
  && chmod a+x /usr/bin/xvfb-chromium /usr/bin/google-chrome /usr/bin/chromium-browser

WORKDIR /site
ADD package.json /site/

RUN set -ex \
  && npm install

ADD . /site
