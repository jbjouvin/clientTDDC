FROM node:latest

# set working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# add environment variables
ARG REACT_APP_USERS_SERVICE_URL
ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
ENV REACT_APP_USERS_SERVICE_URL $REACT_APP_USERS_SERVICE_URL

# install and cache app dependencies
ADD package.json /usr/src/app/package.json
RUN npm install --silent
RUN npm install react-scripts@0.9.5 -g --silent

# add app
ADD . /usr/src/app

# build react app
RUN npm run build

# start app
CMD ["pushstate-server", "build"]