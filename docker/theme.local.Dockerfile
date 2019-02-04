FROM node:lts-alpine

RUN apk add --no-cache bash\
  ca-certificates \
  curl \
  mysql-client

RUN yarn config set cache-folder /var/cache/yarn

WORKDIR /theme

COPY docker/bin/theme-entrypoint.sh /usr/local/bin/theme-entrypoint.sh
ENTRYPOINT ["theme-entrypoint.sh"]
CMD ["yarn", "start"]
