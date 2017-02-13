# WallpaperExploitSite
Website to demonstrate an exploit of trust on Android using a Live Wallpaper

1. Setup Docker on a server of your choosing.  
2. Replace all instances of `openshell.nextproject.ca` in install.sh with the domain of your server.  
3. Get a certificate from Lets Encrypt using their Certbot manually which installs it to the host.  
4. Ensure that ports 23, 80, 443, 2121, 2222, 8000, 10000-10009 and 21210-21220 are available.  
5. Run `chmod +x install.sh && ./install.sh` to setup all the containers!  

Once all the containers are up and running, you are ready to build [the app here.](https://github.com/uoitdnalab/OpenShellApp)  

If you are running the site for more than a few months, you'll need to renew your SSL certificate.  
This can be done with the included `renew.sh` script by changing the domain name inside as well.  
