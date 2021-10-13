FROM php:7.4-cli

LABEL author=sven.wesley@gmail.com

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \ 
    libicu-dev \ 
    libjpeg62-turbo-dev \ 
    libmcrypt-dev \ 
    libpng-dev \ 
    libsodium-dev \
    libxslt1-dev \
    libzip-dev \
    libonig-dev \ 
    sudo \ 
    cron \ 
    rsyslog \ 
    default-mysql-client \ 
    git \
    supervisor \
    librabbitmq-dev \
    amqp-tools \
    unzip \
    procps \
    htop \
    vim

# Configure the gd library
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install required PHP extensions
RUN docker-php-ext-install \
  gd \
  intl \
  mbstring \
  pdo_mysql \
  xsl \
  zip \
  soap \
  bcmath \
  sockets

RUN pecl install -o -f xdebug; pecl install mcrypt; docker-php-ext-enable mcrypt; pecl install amqp

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /srv/site

ENV DEBUG false

ADD root/bashrc /root/.bashrc
ADD etc/php.ini /usr/local/etc/php/conf.d/zz-magento.ini
ADD etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini

ADD fpm-cli.sh /fpm-cli.sh

RUN chmod +x /fpm-cli.sh

ENTRYPOINT ["/fpm-cli.sh"]

VOLUME /root/.composer/cache

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.23

ADD bin/* /usr/local/bin/

RUN chmod -R +x /usr/local/bin \
 && mkdir /srv/site \
 && mkdir /var/www/.composer \
 && chown -R www-data:www-data /srv \
 && chmod -R 755 /srv \
 && chown www-data /var/www/.composer \
 && chgrp www-data /var/www/ \
 && chgrp www-data /var 

CMD ["bash"]
