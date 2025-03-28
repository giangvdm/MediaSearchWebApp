# Base image
FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    git \
    nano \
    libzip-dev \
    libpq-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install NPM
RUN apt update && apt install -y nodejs npm

# Set working directory
WORKDIR /var/www/app

# Copy project files
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www && chmod -R 775 /var/www

EXPOSE 9000
CMD ["php-fpm"]
