# Install script to create the four containers and run them
# Assumes Docker is already installed along with LetsEncrypt
# git clone https://github.com/uoitdnalab/OpenShellSite.git && cd OpenShellSite && chmod +x install.sh && ./install.sh
sudo docker build -t "openshell_site" .
sudo docker run -itd -p 80:80 -p 443:443 --name OpenShell_Site --restart=always openshell_site:latest
sudo docker cp --follow-link /etc/letsencrypt/live/openshell.nextproject.ca/cert.pem OpenShell_Site:/etc/letsencrypt/live/openshell.nextproject.ca/cert.pem
sudo docker cp --follow-link /etc/letsencrypt/live/openshell.nextproject.ca/privkey.pem OpenShell_Site:/etc/letsencrypt/live/openshell.nextproject.ca/privkey.pem
sudo docker cp --follow-link /etc/letsencrypt/live/openshell.nextproject.ca/chain.pem OpenShell_Site:/etc/letsencrypt/live/openshell.nextproject.ca/chain.pem
sudo docker exec OpenShell_Site service apache2 restart

cd ~
git clone https://github.com/liftoff/GateOne.git # Clone the repo
cd GateOne/docker
sudo docker build -t gateone .
sudo docker run -d --name=Gateone -p 8000:8000 --restart=always gateone
sudo docker cp --follow-link /etc/letsencrypt/live/openshell.nextproject.ca/cert.pem Gateone:/etc/gateone/ssl/certificate.pem
sudo docker cp --follow-link /etc/letsencrypt/live/openshell.nextproject.ca/privkey.pem Gateone:/etc/gateone/ssl/keyfile.pem

cd ~/OpenShellSite/gateoneJail
sudo docker build -t gateone_jail .
sudo docker run -itd --name=Gateone_Jail -p 23:23 -p 2222:2222 -p 10000:10000 -p 10001:10001 -p 10002:10002 -p 10003:10003 -p 10004:10004 -p 10005:10005 -p 10006:10006 -p 10007:10007 -p 10008:10008 -p 10009:10009 --restart=always --privileged gateone_jail

cd ~/OpenShellSite/ftp_server
sudo docker build -t ftp_server .
sudo docker run -itd -p 2121:2121 -p 21210-21220:21210-21220 --name FTP_Server --restart=always ftp_server
