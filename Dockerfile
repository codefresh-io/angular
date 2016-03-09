FROM node:latest

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN npm install --silent -g gulp
RUN npm install --silent -g protractor

COPY package.json .
COPY npm-shrinkwrap.json node_modules/.npm-shrinkwrap.cached.json
RUN npm install --silent

COPY modules/angular2/tsd.json modules/angular2/tsd.json
RUN $(npm bin)/tsd reinstall --overwrite --clean --config modules/angular2/tsd.json
COPY tools/tsd.json tools/tsd.json
RUN $(npm bin)/tsd reinstall --overwrite --clean --config tools/tsd.json
COPY modules/angular1_router/tsd.json modules/angular1_router/tsd.json
RUN $(npm bin)/tsd reinstall --overwrite --config modules/angular1_router/tsd.json


COPY . .

#RUN gulp lint

#RUN gulp build.js

#RUN gulp test.unit.js/ci

