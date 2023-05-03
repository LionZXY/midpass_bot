FROM node:16-alpine

RUN apk add --no-cache bash coreutils tzdata

ENV TZ="Europe/Moscow"
ENV CRON_TIME = "0 8"

WORKDIR /app

COPY package.json /app/
COPY package-lock.json /app/

RUN npm install

COPY . /app/

RUN npm run build

CMD echo "$CRON_TIME * * * cd /app/ && ./entrypoint.sh" > /var/spool/cron/crontabs/root && crond -f -l 2
