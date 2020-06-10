FROM phpdockerio/php74-fpm:latest

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
       git \
       less \
       mysql-client \
       php-memcached \
       php-pclzip \
       php-redis \
       php-xdebug \
       php-zip \
       php7.4-bcmath \
       php7.4-bz2 \
       php7.4-gd \
       php7.4-igbinary \
       php7.4-imagick \
       php7.4-imap \
       php7.4-intl \
       php7.4-mysql \
       php7.4-soap \
       php-mbstring \
       ssmtp \
       unzip \
       zip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# WP CLI
RUN echo "installing WP-CLI" \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy pool customizations to make the www pool run as the squareone user
COPY overrides.conf /etc/php/7.4/fpm/pool.d/zzz-overrides.conf

COPY docker-entrypoint.sh /
ADD /docker-entrypoint.d/ /docker-entrypoint.d/
ONBUILD ADD /docker-entrypoint.d/ /docker-entrypoint.d/

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

# Run the original DockerFile's cmd to start php-fpm
CMD /usr/bin/php-fpm

WORKDIR "/application"
