FROM markadams/chromium-xvfb

MAINTAINER stefan.lapers@intersoft.solutions

# Install Node.JS
#
RUN set -ex \
  && apt-get update \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install -y nodejs git && npm install -g npm@latest


# Create a cache of the npm packages that
# only gets updated when the package.json changes
#
WORKDIR /npm_cache
ADD package.json /npm_cache/

RUN set -ex \
  && npm install
