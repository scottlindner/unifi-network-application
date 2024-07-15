FROM ubuntu:24.04

# Based on https://help.ui.com/hc/en-us/articles/220066768-Updating-and-Installing-Self-Hosted-UniFi-Network-Servers-Linux

# update linux
RUN apt-get update
RUN apt-get full-upgrade
RUN apt-get autoremove

# Install Required packages and add new source list
RUN apt-get install -y ca-certificates curl gnupg
RUN apt-get install -y apt-transport-https
RUN apt-get install -y wget
RUN echo 'deb [ arch=amd64,arm64 ] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
RUN wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg

# Install MongoDB
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
RUN echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

# Install Unifi Network Application
RUN apt-get update
RUN apt-get install -y unifi

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]