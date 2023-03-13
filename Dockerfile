FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip supervisor

RUN pecl install redis \
    && docker-php-ext-enable redis

WORKDIR /var/www

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ADD ./ ./
RUN composer install
EXPOSE 8000

COPY ./laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf

CMD service supervisor start \
    && php artisan serve --host 0.0.0.0 --port 8000
