FROM php:7.2.31-fpm

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# PHP extension installation helper. See https://github.com/mlocati/docker-php-extension-installer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
       default-mysql-client \
       git \
       gosu \
       less \
       libsodium-dev \
       msmtp \
       procps \
       unzip \
       wget \
       zip \
    && install-php-extensions \
       apcu \
       bcmath \
       bz2 \
       curl \
       dom \
       exif \
       fileinfo \
       filter \
       gd \
       hash \
       iconv \
       igbinary \
       imagick \
       imap \
       intl \
       json \
       mbstring \
       mcrypt \
       memcached \
       mysqli \
       opcache \
       openssl \
       pcntl \
       pcre \
       pdo_mysql \
       readline \
       redis \
       simplexml \
       soap \
       sodium \
       xdebug \
       xml \
       xmlreader \
       yaml \
       zip \
       zlib \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --1 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer


# Install fixuid to set the PHP-FPM user
ARG PHP_USER=squareone
RUN addgroup --gid 1000 "$PHP_USER" \
    && adduser --uid 1000 --ingroup "$PHP_USER" --home "/home/$PHP_USER" --shell /bin/bash --disabled-password --gecos "" "$PHP_USER" \
    && curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.5/fixuid-0.5-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - \
    && chown root:root /usr/local/bin/fixuid \
    && chmod 4755 /usr/local/bin/fixuid \
    && mkdir -p /etc/fixuid \
    && printf "user: $PHP_USER\ngroup: $PHP_USER\n" > /etc/fixuid/config.yml

# WP CLI
RUN echo "installing WP-CLI" \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

USER "$PHP_USER:$PHP_USER"

COPY docker-entrypoint /usr/local/bin/
COPY docker-entrypoint.d /docker-entrypoint.d/

ENTRYPOINT ["docker-entrypoint"]

WORKDIR "/application"
