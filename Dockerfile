FROM alpine:latest
RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add ca-certificates
RUN apk add curl
RUN apk add mysql-client
RUN apk add php7
RUN apk add php7-fpm
RUN apk add php7-json
RUN apk add php7-zlib
RUN apk add php7-xml
RUN apk add php7-pdo
RUN apk add php7-phar
RUN apk add php7-openssl
RUN apk add php7-pdo_mysql
RUN apk add php7-mysqli
RUN apk add php7-session
RUN apk add php7-gd
RUN apk add php7-iconv
RUN apk add php7-mcrypt
RUN apk add php7-curl
RUN apk add php7-opcache
RUN apk add php7-ctype
RUN apk add php7-apcu
RUN apk add php7-intl
RUN apk add php7-bcmath
RUN apk add php7-mbstring
RUN apk add php7-dom
RUN apk add php7-xmlreader
RUN apk add php7-simplexml
RUN rm -rf /var/cache/apk/*

# WORDPRESS CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php ./wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# BEDROCK
VOLUME [ "/data" ]
WORKDIR /data
CMD ["wp", "server", "--docroot=web", "--host=0.0.0.0"]
