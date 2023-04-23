FROM node:16-alpine

ENV TZ=Europe/Moscow

WORKDIR /app
COPY . /app/

RUN npm install
RUN npm run build
RUN echo "10 13 * * * cd /app/ && ./entrypoint.sh" >> /var/spool/cron/crontabs/root

CMD crond -f -l 2