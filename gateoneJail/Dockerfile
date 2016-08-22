# Build from the previously build gateone Docker image
FROM gateone:latest

#Install Netcat which is needed to create a tunnel listener for the exploit demo
RUN apt-get update && apt-get install -y \
netcat

#Expose port 22 for SSH access to the jail
EXPOSE 22

#Set an environment variable for the location of the jail
ENV D /home/jails

#Make directories for the jail and prepare them for the script
RUN mkdir -p $D && \
	mkdir -p $D/dev/ && \
	mknod -m 666 $D/dev/null c 1 3 && \
	mknod -m 666 $D/dev/tty c 5 0 && \
	mknod -m 666 $D/dev/zero c 1 5 && \
	mknod -m 666 $D/dev/random c 1 8 && \
	chown root:root $D && \
	chmod 0755 $D && \
	ls -ld $D && \
	mkdir -p $D/bin
	

#Copy over the script used to add binaries and their required libraries to the jail
COPY ./jail.sh /root/jail.sh
RUN chmod +x /root/jail.sh

#Run the script to add Bash and Netcat and their libraries to the jail
RUN cp -v /bin/bash $D/bin/ && \
	/root/jail.sh /bin/bash && \
	cp -v /bin/nc $D/bin/ && \
	/root/jail.sh /bin/nc

#Add the demo user to the container and set its password
RUN useradd demo && \
	/bin/bash -c "chpasswd <<< "demo:demopassword""

#Copy the user and group files to the jail and create a home directory	
RUN mkdir -p $D/etc/ && \
	/bin/bash -c "cp -vf /etc/{passwd,group} $D/etc/" && \
	mkdir -p $D/home/demo && \
	chown -R demo:demo $D/home/demo/ && \
	chmod -R 0700 $D/home/demo/

#Modify the SSH config file to change the demo user's root directory to the jail
RUN echo "Match User demo" >> /etc/ssh/sshd_config && \
	echo "ChrootDirectory /home/jails" >> /etc/ssh/sshd_config
# ForceCommand nc -l -p 10000
