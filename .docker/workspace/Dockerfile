FROM debian:bookworm-slim

# Environment variables
ENV PUID=1000
ENV PGID=1000
ENV USER='invoiceshelf'
ENV PHP_TZ=UTC

ENV NVM_DIR /home/invoiceshelf/.nvm

# Arguments
# To use the latest InvoiceShelf release instead of master pass `--build-arg TARGET=release` to `docker build`
ARG TARGET=dev
# To install composer development dependencies, pass `--build-arg COMPOSER_NO_DEV=0` to `docker build`
ARG COMPOSER_NO_DEV=1

# Install base dependencies, add user and group, clone the repo and install php libraries
RUN \
    set -ev && \
    apt-get update && \
    apt-get upgrade -qy && \
    apt-get install -qy --no-install-recommends\
    adduser \
    php8.2-mysql \
    php8.2-pgsql \
    php8.2-sqlite3 \
    php8.2-imagick \
    php8.2-mbstring \
    php8.2-gd \
    php8.2-xml \
    php8.2-zip \
    php8.2-fpm \
    php8.2-redis \
    php8.2-bcmath \
    php8.2-intl \
    php8.2-curl \
    curl \
    git \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    webp \
    composer \
    cron \
    nano \
    zip \
    unzip

# Force the proper PHP version
RUN update-alternatives --set php /usr/bin/php8.2 && \
    update-alternatives --set phar /usr/bin/phar8.2 && \
    update-alternatives --set phar.phar /usr/bin/phar.phar8.2

RUN mkdir -p /var/www/html

RUN addgroup --gid "$PGID" "$USER" && \
    adduser --gecos '' --disabled-password --uid "$PUID" --gid "$PGID" "$USER"

# Install Composer for Laravel/Codeigniter
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

USER invoiceshelf

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.3/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install 20 && \
    nvm use 20 && \
    nvm alias default 20

COPY ./.bashrc $HOME/.bashrc
COPY ./.bashrc /root/.bashrc

RUN echo "" >> ~/.bashrc && \
    echo "export PS1='\W '" >> ~/.bashrc && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc

# Add NVM binaries to root's .bashrc
USER root
RUN echo "" >> ~/.bashrc && \
    echo "export PS1='\W '" >> ~/.bashrc && \
    echo 'export NVM_DIR="/home/invoiceshelf/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc

USER invoiceshelf
RUN [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    curl -o- -L https://yarnpkg.com/install.sh | bash; \
    echo "" >> ~/.bashrc && \
    echo "export PS1='\W '" >> ~/.bashrc && \
    echo 'export PATH="$HOME/.yarn/bin:$PATH"' >> ~/.bashrc

# Add Yarn binaries to root's .bashrc
USER root
RUN echo "" >> ~/.bashrc && \
    echo "export PS1='\W '" >> ~/.bashrc && \
    echo 'export YARN_DIR="/home/invoiceshelf/.yarn"' >> ~/.bashrc && \
    echo 'export PATH="$YARN_DIR/bin:$PATH"' >> ~/.bashrc

RUN apt-get clean && \
    apt-get purge -y --autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



