# Get started with local development

### Preliminary setup

- Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
- Install Vagrant: https://www.vagrantup.com/downloads.html
- Navigate to a directory where you want to handle local development
- Clone the repo
- Open a command line in your new directory and execute the following commands:

```vagrant up``` _this will take a few minutes the first time..._

```vagrant ssh```

- Once ssh'd into the virtual machine, execute the following commands to install Docker:

```sudo apt update```

```sudo apt install apt-transport-https ca-certificates curl software-properties-common```

```curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -```

```sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"```

```sudo apt update```

```sudo apt install docker-ce```

```docker -v``` _this verifies that Docker is installed properly_

- Now install Docker Compose:

```sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose```

```sudo chmod +x /usr/local/bin/docker-compose```

```docker-compose --version``` _this verifies that Docker Compose is installed properly_

### Starting and stopping the local server resources

- Execute the following command to start up the local server resources

```cd /vagrant```

```sudo docker-compose up -d```

- Execute the following command to shut down the local server resources

```sudo docker-compose down```

### Common commands

- Reloading nginx (such as after updating a configuration file):

```sudo docker exec nginx sh``` _Start a shell prompt in the nginx service (must be ssh'd into vagrant)_

```nginx -s reload``` _reloads nginx_

- Start a shell prompt in the PHP7 service (must be ssh'd into vagrant):

```sudo docker exec php7 bash```

composer create-project --prefer-dist laravel/laravel projectname
