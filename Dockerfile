FROM markadams/chromium-xvfb

MAINTAINER stefan.lapers@intersoft.solutions

# Create a cache of the npm packages that
# only gets updated when the package.json changes
#
WORKDIR /npm_cache
ADD package.json /npm_cache/

RUN set -ex \
  && npm install
