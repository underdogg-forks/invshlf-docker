FROM php:8.2-fpm-bookworm as base

# Environment variables
ENV PUID=1000
ENV PGID=1000
ENV USER='invoiceshelf'
ENV PHP_TZ=UTC

RUN addgroup --gid "$PGID" "$USER" && \
    adduser --gecos '' --disabled-password --uid "$PUID" --gid "$PGID" "$USER" && \
    usermod -a -G "$USER" www-data

COPY setup.sh /usr/local/bin/setup.sh

# Make script executable
RUN chmod +x /usr/local/bin/setup.sh

#RUN chown -R www-data:www-data /var/www && \
#    chmod 775 /var/www/html/InvoiceShelf/storage/logs && \
#    chmod 775 /var/www/html/InvoiceShelf/storage/framework && \
#    chmod 775 /var/www/html/InvoiceShelf/storage/cache
    #chmod 775 /var/www/html/InvoiceShelf/bootstrap/cache

RUN mkdir -p /var/www/html

RUN chown -R www-data:www-data /var/www/html

USER root

WORKDIR /var/www/html

CMD [ "php-fpm" ]

EXPOSE 9000
