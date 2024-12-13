FROM node:22-alpine

RUN apk update && apk add openssl

WORKDIR /app

COPY . .

RUN yarn install

RUN chmod +x sslgenerator.sh

RUN sh sslgenerator.sh

CMD [ "node", "server.js" ]