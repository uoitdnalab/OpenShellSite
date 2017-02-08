# Build from the official Ubuntu 14.04 Trusty Tahr Docker image
FROM ubuntu:14.04

# I am the maintainer - Dylan Kauling
MAINTAINER dylan.kauling@uoit.net

# Update the apt-get cache to latest and
# Install KCS_Site required packages
RUN apt-get update && apt-get install -y \
	apache2

# Expose port 80 for HTTP and 443 for HTTPS traffic
EXPOSE 80 443

# Enable SSL and copy over the config file
RUN a2enmod ssl
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
RUN a2ensite default-ssl.conf

#Make directory for the certificate and key
RUN mkdir -p /etc/letsencrypt/live/openshell.nextproject.ca

#Copy the site over to the web directory
COPY ./public_html/ /var/www/html/

#Set bash to restart the web server when the container is started
RUN echo "service apache2 restart" >> /etc/bash.bashrc

#Default to start a bash shell when the container is run
CMD ["/bin/bash"]

# Helper commands to run the build and start the container

# Proxy
# docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy

# Docker
# docker build -t "openshell_site" .
# docker run -itd -e VIRTUAL_HOST=wallpaperexploit.ddns.net -p 443:443 --name OpenShell_Site wallpaper_site:latest
# docker cp --follow-link /etc/letsencrypt/live/openshell.nextproject.ca/cert.pem Wallpaper_Site:/etc/letsencrypt/live/openshell.nextproject.ca/cert.pem
# docker cp --follow-link /etc/letsencrypt/live/openshell.nextproject.ca/privkey.pem Wallpaper_Site:/etc/letsencrypt/live/openshell.nextproject.ca/privkey.pem
# docker cp --follow-link /etc/letsencrypt/live/openshell.nextproject.ca/chain.pem Wallpaper_Site:/etc/letsencrypt/live/openshell.nextproject.ca/chain.pem
# docker exec Wallpaper_Site service apache2 start

# mkdir -p /var/nginx-proxy/certs
# openssl x509 -outform der -in /etc/letsencrypt/live/openshell.nextproject.ca/cert.pem -out /var/nginx-proxy/certs/openshell.nextproject.ca.crt
# openssl rsa -outform der -in /etc/letsencrypt/live/openshell.nextproject.ca/privkey.pem -out /var/nginx-proxy/certs/openshell.nextproject.ca.key

# docker run -itd -e VIRTUAL_HOST=openshell.nextproject.ca --name OpenShell_Site openshell_site:latest
# docker run -itd -e VIRTUAL_HOST=openshell.nextproject.ca -e VIRTUAL_PROTO=https -e VIRTUAL_PORT=443 --name OpenShell_Site openshell_site:latest
# docker run -d -p 80:80 -p 443:443 -v /var/nginx-proxy/certs:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock:ro --name Nginx_Proxy jwilder/nginx-proxy
