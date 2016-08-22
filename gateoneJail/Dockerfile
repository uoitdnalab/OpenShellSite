# Build from the official Ubuntu 14.04 Trusty Tahr Docker image
FROM ubuntu:14.04

# I am the maintainer - Dylan Kauling
MAINTAINER dylan.kauling@uoit.net

#Install Netcat which is needed to create a tunnel listener for the exploit demo
RUN apt-get update && apt-get install -y \
	netcat \
	openssh-server

#Expose port 2222 for SSH access to the jail and 10000 for the exploit tunnel
EXPOSE 2222 10000

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

#Manually add Bash and Netcat and their libraries to the jail
RUN cp -v /bin/bash $D/bin/ && \
	mkdir -p $D/lib64/ && \
	mkdir -p $D/lib/x86_64-linux-gnu/ && \
	/bin/bash -c "cp -v /lib/x86_64-linux-gnu/{libtinfo.so.5,libdl.so.2,libc.so.6} $D/lib/" && \
	cp -v /lib64/ld-linux-x86-64.so.2 $D/lib64/ && \
	cp -va /lib/x86_64-linux-gnu/libnss_files* $D/lib/x86_64-linux-gnu/ && \
	cp -v /bin/nc $D/bin/ && \
	cp -v /lib/x86_64-linux-gnu/{libbsd.so.0,libresolv.so.2} $D/lib/ && \

#Add the demo user to the container and set its password
RUN useradd demo --shell /bin/bash && \
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

#Default to start a bash shell when the container is run
CMD ["/bin/bash"]
