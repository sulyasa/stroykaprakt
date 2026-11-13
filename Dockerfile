FROM php:8.2-apache

# Установка расширения pdo_sqlite для работы с базой данных
RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite \
    && rm -rf /var/lib/apt/lists/*

# Включение модуля rewrite
RUN a2enmod rewrite

# Копирование файлов проекта
COPY . /var/www/html/

# Настройка прав на папку данных и кеша для пользователя www-data
RUN mkdir -p /var/www/html/data/cache \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html/data

EXPOSE 80

CMD ["apache2-foreground"]
