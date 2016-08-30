# Script to renew the certificates and restart the docker containers

# Stop the containers using the certs
docker stop Wallpaper_Site
docker stop Gateone

# Renew the certs
letsencrypt renew --standalone --agree-tos --manual-public-ip-logging-ok

# Copy the certs to the containers
docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/cert.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaper.nextproject.ca/cert.pem
docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/privkey.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaper.nextproject.ca/privkey.pem
docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/chain.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaper.nextproject.ca/chain.pem
docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/cert.pem Gateone:/etc/gateone/ssl/certificate.pem
docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/privkey.pem Gateone:/etc/gateone/ssl/keyfile.pem

# Start the containers again
docker start Wallpaper_Site
docker exec Wallpaper_Site service apache2 restart
docker start Gateone
