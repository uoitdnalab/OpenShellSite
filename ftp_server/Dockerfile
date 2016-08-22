# Build from the official Debian Docker image
FROM debian

# Expose port 2121 for the FTP server and 21210-21220 for passive mode
EXPOSE 2121 21210-21220

# Install vsftpd to use as an ftp server for the demo
RUN apt-get update && apt-get install -y \
	vsftpd
	
# Copy the pre-made vsftpd config file to the container
COPY vsftpd.conf /etc/vsftpd.conf

# Add the ftp user to the container and set its password
RUN useradd ftpdemo && \
	/bin/bash -c "chpasswd <<< "ftpdemo:ftppassword""

# Create a home directory for the ftpdemo user and chown the files directory inside
RUN mkdir -p /home/ftpdemo/files && \
	chown ftpdemo:ftpdemo /home/ftpdemo/files
	
# Default to start a bash shell when the container is run
CMD ["/bin/bash"]
