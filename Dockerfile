FROM alpine:edge

MAINTAINER Engit Prabhat <engitj@gmail.com>

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk --update add \
    curl git unzip \
	mongodb \
    bash \
	nginx \
    php7 \
    php7-bcmath \
    php7-dom \
    php7-ctype \
    php7-curl \
    php7-fileinfo \
    php7-fpm \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-phar \
    php7-posix \
    php7-session \
    php7-soap \
    php7-xml \
    php7-xmlreader \
    php7-xmlwriter \
    php7-zlib \
    php7-mongodb \
    php7-tokenizer \
    php7-zip

RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php7/php.ini

# Install Composer
RUN curl -s https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN rm -rf /var/cache/apk/* \
    && rm -rf /var/www/html/* \
    && mkdir -p /var/www/html/storage \
    && chmod 777 -R /var/www/html/storage \
    && rm /usr/bin/mongoperf \
    && rm /etc/nginx/conf.d/default.conf

# Copy website Nginx config file
COPY ./configs/site.conf /etc/nginx/conf.d/default.conf

VOLUME /var/www/html

EXPOSE 80 27017

ADD ./configs/start.sh /start.sh
RUN chmod +x /start.sh && \
    mkdir -p /data/db && \
    mkdir /run/nginx && \
    mkdir /run/php

CMD /start.sh