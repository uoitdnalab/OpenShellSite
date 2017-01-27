# Build from the official Ubuntu 14.04 Trusty Tahr Docker image
FROM ubuntu:14.04

# I am the maintainer - Dylan Kauling
MAINTAINER dylan.kauling@uoit.net

#Install Netcat which is needed to create a tunnel listener for the exploit demo
RUN apt-get update && apt-get install -y \
	netcat \
	openssh-server \
	screen \
	xinetd \
	telnetd

#Expose port 2222 for SSH access to the jail, 23 for telnet, and 10000 for the exploit tunnel
EXPOSE 23 2222 10000

#Set an environment variable for the location of the jail
ENV D /home/jails

#Set an environment variable for the location of terminal stuff for screen
ENV TERMINFO /usr/share/terminfo/

#Make directories for the jail and prepare them for the script
RUN mkdir -p $D && \
	mkdir -p $D/dev/ && \
	mknod -m 666 $D/dev/null c 1 3 && \
	mknod -m 666 $D/dev/tty c 5 0 && \
	mknod -m 666 $D/dev/zero c 1 5 && \
	mknod -m 666 $D/dev/random c 1 8 && \
	mknod -m 666 $D/dev/ptmx c 5 2 && \
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
	/bin/bash -c "cp -v /lib/x86_64-linux-gnu/{libbsd.so.0,libresolv.so.2} $D/lib/" && \
	cp -v /usr/bin/screen $D/bin/ && \
	/bin/bash -c "cp -v /lib/x86_64-linux-gnu/{libcrypt.so.1,libpam.so.0,libaudit.so.1} $D/lib/" && \
	cp -v /usr/bin/script $D/bin/ && \
	/bin/bash -c "cp -v /lib/x86_64-linux-gnu/libutil.so.1 $D/lib/" && \
	cp -v /bin/su $D/bin/ && \
	/bin/bash -c "cp -v /lib/x86_64-linux-gnu/libpam_misc.so.0 $D/lib/"

#Add the demo user to the container and set its password
RUN useradd demo --shell /bin/bash && \
	/bin/bash -c "chpasswd <<< "demo:demopassword""

#Copy the user and group files to the jail and create a home directory	
RUN mkdir -p $D/etc/ && \
	/bin/bash -c "cp -vf /etc/{passwd,group} $D/etc/" && \
	mkdir -p $D/home/demo && \
	chown -R demo:demo $D/home/demo/ && \
	chmod -R 0700 $D/home/demo/

#Copy over the pre-configured SSH config file with the chroot added and port changed to 2222
COPY sshd_config /etc/ssh/sshd_config

#Set bash to restart the ssh server when the container is started
RUN echo "service ssh restart" >> /etc/bash.bashrc

#Default to start a bash shell when the container is run
CMD ["/bin/bash"]

#Run these commands inside the container afterwards
#mkdir $D/proc && mount -t proc proc $D/proc && mkdir $D/dev/pts && mount -t devpts none "$D/dev/pts" -o ptmxmode=0666
#mkdir -p $D/var/run/screen && chmod 777 $D/var/run/screen && touch $D/var/run/utmp && mkdir -p $D/usr/share
#cp -R /usr/share/terminfo $D/usr/share/ && cd $D/usr/share/terminfo/x && ln -s xterm-new xterm
