FROM php:7.3-fpm

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
    librabbitmq-dev \
    sudo \
    unzip

# Configure the gd library
RUN docker-php-ext-configure gd --with-freetype-dir --with-jpeg-dir

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

# Pecl installs
RUN pecl install -o -f xdebug; pecl install mcrypt; docker-php-ext-enable mcrypt; pecl install amqp

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /srv/site

ENV DEBUG false
ENV UPDATE_UID_GID false

ADD etc/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD etc/php.ini /usr/local/etc/php/conf.d/zz-magento.ini
ADD etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini

ADD fpm.sh /fpm.sh

RUN ["chmod", "+x", "/fpm.sh"]

ENTRYPOINT ["/fpm.sh"]

ENV MAGENTO_RUN_MODE production
ENV UPLOAD_MAX_FILESIZE 64M

ADD etc/php-fpm.conf /usr/local/etc/

CMD ["php-fpm", "-F"]
