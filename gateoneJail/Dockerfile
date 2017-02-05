# Build from the official Ubuntu 14.04 Trusty Tahr Docker image
FROM ubuntu:14.04

# I am the maintainer - Dylan Kauling
MAINTAINER dylan.kauling@uoit.net

#Install Netcat which is needed to create a tunnel listener for the exploit demo
RUN apt-get update && apt-get install -y \
	netcat \
	openssh-server \
	screen

#Expose port 2222 for SSH access to the jail and 10000-10009 for the exploit tunnels
EXPOSE 2222 10000-10009

#Add the demo user to the container and set its password with long expiry
RUN useradd demo --shell /bin/bash && \
	/bin/bash -c "chpasswd <<< "demo:demopassword"" && \
	passwd -n 10000 demo

#Create a home directory for the new user
RUN mkdir -p /home/demo/ && \
	chown -R demo:demo /home/demo/ && \
	chmod -R 0700 /home/demo/

#Copy over the pre-configured SSH config file with the port changed to 2222
COPY sshd_config /etc/ssh/sshd_config

#Copy over the pre-configured bash profile to launch netcat listeners automatically
COPY .bash_profile /home/demo/.bash_profile

#Set bash to restart the ssh server when the container is started
#RUN echo "service ssh restart" >> /etc/bash.bashrc

#Default to start a bash shell when the container is run
CMD ["/bin/bash", "-c", "service ssh restart"]
