# Use latest docker container
FROM wordpress:latest

# Increase max file size for uploads
RUN touch /usr/local/etc/php/conf.d/uploads.ini \
    && echo 'upload_max_filesize = 100M;' >> /usr/local/etc/php/conf.d/uploads.ini

# Direct download updates without FTP
RUN echo "define('FS_METHOD','direct');" >> /var/www/html/wp-config.php

# Create upload dir
RUN mkdir /var/www/html/wp-content/uploads

# Copy and make startscript executable.
# Startscript is needed for set user right of the
# previously created uploads folder since
# changing the user right from this
# docker file will not be persistent
COPY startscript.sh /
RUN chmod +x /startscript.sh

ENTRYPOINT ["/startscript.sh"]
