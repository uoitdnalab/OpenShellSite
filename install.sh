sudo docker build -t "wallpaper_site" .
sudo docker run -itd -e VIRTUAL_HOST=wallpaperexploit.ddns.net -p 443:443 --name Wallpaper_Site wallpaper_site:latest
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaperexploit.ddns.net/cert.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaperexploit.ddns.net/cert.pem
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaperexploit.ddns.net/privkey.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaperexploit.ddns.net/privkey.pem
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaperexploit.ddns.net/chain.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaperexploit.ddns.net/chain.pem
sudo docker exec Wallpaper_Site service apache2 start
git clone https://github.com/liftoff/GateOne.git # Clone the repo
cd GateOne/docker
sudo docker build -t gateone . # Always tag your builds!
sudo docker run -t --name=Gateone -p 8000:8000 gateone
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaperexploit.ddns.net/cert.pem Gateone:/etc/gateone/ssl/certificate.pem
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaperexploit.ddns.net/privkey.pem Gateone:/etc/gateone/ssl/keyfile.pem
# cd ..
# cd ..
# cd gateoneJail
# sudo docker build -t gateone_jail .
# sudo docker run -t --name=Gateone_Jail -p 8000:8000 gateone_jail
# sudo docker cp --follow-link /etc/letsencrypt/live/wallpaperexploit.ddns.net/cert.pem Gateone_Jail:/etc/gateone/ssl/certificate.pem
# sudo docker cp --follow-link /etc/letsencrypt/live/wallpaperexploit.ddns.net/privkey.pem Gateone_Jail:/etc/gateone/ssl/keyfile.pem
