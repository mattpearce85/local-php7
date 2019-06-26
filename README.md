Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
Install Vagrant: https://www.vagrantup.com/downloads.html
Navigate to a directory where you want to handle local development
Clone the repo

Open a command line in your new directory and execute the following commands:

vagrant up
vagrant ssh

Once ssh'd into the virtual machine, execute the following commands to install Docker:

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
docker -v

sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

Execute the following command to start up the local server resources

sudo docker-compose up -d

Execute the following command to shut down the local server resources
