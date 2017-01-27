# Install script to create the four containers and run them
# Assumes Docker is already installed along with LetsEncrypt
# git clone https://github.com/Gunsmithy/WallpaperExploitSite.git && cd WallpaperExploitSite && chmod +x install.sh && ./install.sh
sudo docker build -t "wallpaper_site" .
sudo docker run -itd -p 80:80 -p 443:443 --name Wallpaper_Site --restart=always wallpaper_site:latest
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/cert.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaper.nextproject.ca/cert.pem
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/privkey.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaper.nextproject.ca/privkey.pem
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/chain.pem Wallpaper_Site:/etc/letsencrypt/live/wallpaper.nextproject.ca/chain.pem
sudo docker exec Wallpaper_Site service apache2 restart

cd ~
git clone https://github.com/liftoff/GateOne.git # Clone the repo
cd GateOne/docker
sudo docker build -t gateone .
sudo docker run -d --name=Gateone -p 8000:8000 --restart=always gateone
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/cert.pem Gateone:/etc/gateone/ssl/certificate.pem
sudo docker cp --follow-link /etc/letsencrypt/live/wallpaper.nextproject.ca/privkey.pem Gateone:/etc/gateone/ssl/keyfile.pem

cd ~/WallpaperExploitSite/gateoneJail
sudo docker build -t gateone_jail .
sudo docker run -itd --name=Gateone_Jail -p 23:23 -p 2222:2222 -p 10000:10000 --restart=always --privileged gateone_jail

cd ~/WallpaperExploitSite/ftp_server
sudo docker build -t ftp_server .
sudo docker run -itd -p 2121:2121 -p 21210-21220:21210-21220 --name FTP_Server --restart=always ftp_server
