FROM node:16-alpine

RUN apk add --no-cache bash coreutils tzdata

ENV TZ="Europe/Moscow"

WORKDIR /app

COPY package.json /app/
COPY package-lock.json /app/

RUN npm install

COPY . /app/

RUN npm run build
RUN echo "00 12 * * * cd /app/ && ./entrypoint.sh" >> /var/spool/cron/crontabs/root

CMD crond -f -l 2
