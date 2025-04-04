FROM node:18.19 AS build
# Create a Virtual directory inside the docker image
WORKDIR /dist/src/app
RUN apt-get update -y
#RUN python3 py3-pip make g++

# Copy files from local machine to virtual directory in docker image
COPY . .

#RUN npm i node-gyp-build
#RUN npm install --force
#RUN npm run build

RUN npm install --legacy-peer-deps --silent
RUN npm i -g @angular/cli
RUN ng build --configuration=production

### STAGE 2:RUN ###
# Defining nginx image to be used
FROM nginx:latest AS ngi
# Copying compiled code and nginx config to different folder
# NOTE: This path may change according to your project's output folder 
COPY --from=build /dist/src/app/dist/demo1 /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf
# Exposing a port, here it means that inside the container 
# the app will be using Port 80 while running
EXPOSE 3000
