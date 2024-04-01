FROM nginx:mainline-bookworm as base

COPY nginx.conf /etc/nginx/

RUN \
    set -ev && \
    apt-get update && \
    apt-get upgrade -qy && \
    apt-get install -qy --no-install-recommends nano

ARG PHP_UPSTREAM_CONTAINER=php-fpm
ARG PHP_UPSTREAM_PORT=9000

# Set upstream conf and remove the default conf
RUN echo "upstream php-upstream { server php-fpm:9000; }" > /etc/nginx/conf.d/upstream.conf \
    && rm /etc/nginx/conf.d/default.conf

RUN apt-get purge -y --autoremove && \
    apt-get clean -qy &&\
    rm -rf /var/lib/apt/lists/*

CMD [ "nginx" ]

EXPOSE 80 81 443