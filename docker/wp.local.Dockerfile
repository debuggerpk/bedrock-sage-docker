FROM alpine:3.9


RUN apk update
RUN apk upgrade
RUN apk add --no-cache bash\
  ca-certificates \
  curl \
  mysql-client

# Install PHP
RUN apk add --no-cache --upgrade php7\
  php7-apcu \
  php7-bcmath \
  php7-common \
  php7-ctype \
  php7-curl \
  php7-dev \
  php7-dom \
  php7-fpm \
  php7-gd \
  php7-iconv \
  php7-intl \
  php7-json \
  php7-mbstring \
  php7-mcrypt \
  php7-mysqli \
  php7-opcache \
  php7-openssl \
  php7-pdo \
  php7-pdo_mysql \
  php7-pear \
  php7-phar \
  php7-session \
  php7-simplexml \
  php7-tokenizer \
  php7-xml \
  php7-xmlreader \
  php7-xmlwriter \
  php7-zlib

# Install XDebug
#RUN pecl config-set php_ini /etc/php7/php.ini
#RUN pecl install xdebug
#RUN echo 'zend_extension=/usr/lib/php7/modules/xdebug.so' >> /etc/php7/php.ini
#RUN touch /etc/php7/conf.d/xdebug.ini
#RUN echo 'xdebug.remote_enable = 1' >> /etc/php7/conf.d/xdebug.ini
#RUN echo 'xdebug.remote_autostart = 1' >> /etc/php7/conf.d/xdebug.ini
#RUN echo 'xdebug.remote_connect_back = 1' >> /etc/php7/conf.d/xdebug.ini
#RUN echo 'xdebug.remote_handler = dbgp' >> /etc/php7/conf.d/xdebug.ini
#RUN echo 'xdebug.profiler_enable = 1' >> /etc/php7/conf.d/xdebug.ini
#RUN echo 'xdebug.profiler_output_dir = "/data/web"' >> /etc/php7/conf.d/xdebug.ini
#RUN echo 'xdebug.remote_port = 9000' >> /etc/php7/conf.d/xdebug.ini

# Remove unused dependencies
RUN rm -rf /var/cache/apk/*

RUN mkdir /var/cache/composer
ENV COMPOSER_HOME=/var/cache/composer


# WORDPRESS CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php ./wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# PHP Composer
COPY docker/bin/composer-install.sh /tmp/composer-install.sh
RUN /tmp/composer-install.sh

WORKDIR /site

# Update composer dependencies at runtime
COPY docker/bin/wp-entrypoint.sh /usr/local/bin/wp-entrypoint.sh
ENTRYPOINT ["wp-entrypoint.sh"]
CMD ["wp", "server", "--docroot=web", "--host=0.0.0.0"]
