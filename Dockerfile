#PHASE - 1

# install node with alpine linux container with builder tag
FROM node:alpine as builder

# set app as working DIR
WORKDIR '/app'

# copy package.json to /app (container current DIR)
COPY package.json .

# run npm install command to install all dependencies
RUN npm install

# copy all containt with node_modules form current DIR to /app (container current DIR)
COPY . .

# command build our project in production mode
RUN npm run build

#PHASE - 2

# install nginx server 
FROM nginx

# it will expose port 80 ( we can see deployment on normal url ex. www.<anydomain>.com )
EXPOSE 80

# copy from phase-1 build DIR to nginx default serving DIR usr/share/ngnix/html
COPY --from=builder /app/build usr/share/nginx/html



# docker build . (. represent current DIR) will run this file and build image
# dokcer run -p <anyport>:3000 <image-id> 
# now open localhost:<port> (user port which given as run)

#image-id : copy hash which build using docker build . command