FROM php:7-apache

ARG GRAV_VERSION=latest

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

RUN a2enmod rewrite

RUN apt-get update \
  && apt-get install -y rsync git unzip libyaml-dev libpng-dev libjpeg-dev libzip-dev \
  && pecl install apcu yaml \
  && docker-php-ext-configure gd --with-jpeg \
  && docker-php-ext-configure zip \
  && docker-php-ext-enable apcu yaml \
  && docker-php-ext-install gd opcache zip

RUN curl -o grav.zip -SL https://getgrav.org/download/core/grav-admin/${GRAV_VERSION} \
  && unzip grav.zip -d /tmp \
  && rm grav.zip \
  && rsync -a /tmp/grav-admin/ /var/www/html --exclude user \
  && chown -R www-data:www-data /var/www/html

RUN echo -e \
  "memory_limit = 128M\n" \
  "upload_max_filesize = 64M\n" \
  "post_max_size = 64M\n" \
  > /usr/local/etc/php/conf.d/uploads.ini

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
