#!/bin/bash

# Step 1: Update the package list
apt update

# Step 2: Install the necessary packages
apt install apt-transport-https ca-certificates gnupg2 software-properties-common

# Step 3: Add the GPG key for the Docker repository
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Step 4: Add the Docker repository
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Step 5: Update package list
apt update

# Step 6: Check cache policy
apt-cache policy docker-ce

# Step 7: Install Docker
apt install docker-ce

# Step 8: Test the Docker status
# systemctl status docker

# Step 9: Use Docker command¶
# With the command “docker” you can execute commands in Docker. In addition to this primary command, you can enter options, suboptions and commands.

# $ docker [option] [command] [arguments]

# Step 10: Show the list of subcommands¶
# You can view the list of subcommands by executing the “docker” command in the terminal.

# $ docker
groupadd docker
usermod -aG docker $USER
