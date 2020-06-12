FROM php:7.4.7-fpm

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# PHP extension installation helper. See https://github.com/mlocati/docker-php-extension-installer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
       default-mysql-client \
       git \
       less \
       msmtp \
       unzip \
       wget \
       zip \
    && install-php-extensions \
       apcu \
       bcmath \
       bz2 \
       gd \
       igbinary \
       imagick \
       imap \
       intl \
       memcached \
       mcrypt \
       mysqli \
       opcache \
       pcntl \
       readline \
       redis \
       soap \
       xdebug \
       yaml \
       zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo \
    && composer clear-cache \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer

# WP CLI
RUN echo "installing WP-CLI" \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

WORKDIR "/application"
