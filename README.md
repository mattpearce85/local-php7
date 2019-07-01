# Training resources

- [Official Laravel Documentation (v5.8)](https://laravel.com/docs/5.8)
- [Laravel From Scratch - Video training series](https://laracasts.com/series/laravel-from-scratch-2018)
- [Laravel Best Practices (mainly reference for naming conventions)](http://www.laravelbestpractices.com/)
- [PHP Coding Style Guide (PSR-2)](https://www.php-fig.org/psr/psr-2/)

# Get started with local development

### Preliminary setup

- Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
- Install Vagrant: https://www.vagrantup.com/downloads.html
- Create a new directory where you want to handle local development (I'll use the tilde ("~") symbol to represent this directory going forward)
- Clone the repo using the following command:

```git clone https://github.com/mattpearce85/local-php7.git .```

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

```cd /vagrant``` _/vagrant is mapped to the directory you ran "vagrant up" in (aka "~"), it also houses your web root and everything else_

```sudo docker-compose up -d``` _this will take a few minutes the first time..._

- Execute the following command to shut down the local server resources

```sudo docker-compose down```

### Creating a new Laravel application

- Start a shell prompt in the PHP7 service (must be ssh'd into vagrant):

```sudo docker exec -it php7 bash```

- Navigate to the webroot for php7 code:

```cd /vagrant/webroot/php7/```

- Create the new laravel project

```composer create-project --prefer-dist laravel/laravel projectname```

- Navigate to the project directory and install the front-end dependencies

```cd projectname```

```npm install```

- Compile the front-end resources

```npm run dev``` _this generates flattened versions of your CSS and JS_

- Create a new nginx configuration file so your browser knows how to find the new Laravel app

```touch /vagrant/nginx/sites-enabled/projectname```

- Use your local IDE to open the new configuration file, it will be located where you cloned the repo under `~/nginx/sites-enabled/projectname`
- Copy the contents of another nginx configuration file into your new file, maybe use `laravel-standard` as an example
- Edit the contents of your new configuration file so that `server_name` points to something like `projectname.localhost` and `root` points to something like `/var/www/html/php7/projectname/public/`
- Execute the following commands to reload the nginx configuration:

```sudo docker exec -it nginx sh``` _Start a shell prompt in the nginx service (must be ssh'd into vagrant)_

```nginx -s reload``` _reloads nginx_

- Open the site in your browser by visiting ```http://projectname.localhost```

### Creating a MySQL database for your Laravel application

- Make sure your servers are running and then open your browser to ```http://pma.localhost```
- Login using the username `root` and the password `mysqltemp`
- If you're not already at the phpMyAdmin dashboard, click the logo
- Click the `User Accounts` tab at the top
- Click the `Add user account` tab midway down the page
- Set `User name` equal to your project name and click the `Generate` button to get a password.
- Copy the password to notepad or something, we'll need it next
- Check the box for `Create database with same name and grant all privileges.`
- Scroll down and click the `Go` button in the bottom-right corner
- The database is now ready, lets add the new credentials to the Laravel settings file. In your local IDE open the `.env` file for your project. It will be something like `~/nginx/sites-enabled/projectname/.env` (you might have to show hidden files to see it)
- In the `.env` file set `DB_DATABASE` and `DB_USERNAME` equal to the MySQL database name you just created like projectname, and paste in the password you generated a minute ago in phpMyAdmin
- All done, your application will now use the new database.

### Common commands

- Reloading nginx (such as after updating a configuration file):

```sudo docker exec -it nginx sh``` _Start a shell prompt in the nginx service (must be ssh'd into vagrant)_

```nginx -s reload``` _reloads nginx_

- Start a shell prompt in the PHP7 service (must be ssh'd into vagrant):

```sudo docker exec -it php7 bash```
