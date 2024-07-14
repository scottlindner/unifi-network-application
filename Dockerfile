FROM ubuntu:24.04

# update linux
RUN apt-get update
RUN apt-get full-upgrade
RUN apt-get autoremove

# Install Required packages and add new source list
RUN apt-get install -y ca-certificates curl
RUN apt-get install -y apt-transport-https
RUN echo 'deb [ arch=amd64,arm64 ] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
RUN wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg

# Install MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | sudo apt-key add -
RUN echo "deb [trusted=yes] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
RUN apt-get update

# Install Unifi Network Application
RUN apt-get update && sudo apt-get install unifi -y