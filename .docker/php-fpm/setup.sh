#!/bin/bash

cd /var/www/html/InvoiceShelf || exit

chown -R www-data:www-data /var/www && \
chmod 775 /var/www/html/InvoiceShelf/storage/logs && \
chmod 775 /var/www/html/InvoiceShelf/storage/framework && \
chmod 775 /var/www/html/InvoiceShelf/storage/cache
#chmod 775 /var/www/html/InvoiceShelf/bootstrap/cache