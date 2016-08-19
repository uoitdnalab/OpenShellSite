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

# Copy the KCS site files over from the Host
#COPY ./public_html/ /var/www/html/

# Helper commands to run the build and start the container

# Proxy
# docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy

# Docker
# docker build -t "wallpaper_site" .
# docker run -itd -e VIRTUAL_HOST=wallpaperexploit.eastus.cloudapp.com --name Wallpaper_Site wallpaper_site:latest /bin/bash
# docker exec Wallpaper_Site service apache2 start
