# Training resources

Note: The video training series will help you do things like installing PHP and Laravel. The instructions below will take care of all that. HOWEVER the training videos do a much better job explaining how these commands work and why we're using them. I strongly recommend watching the full video series instead of skipping the parts you think are already done.

- [PHP video training series](https://laracasts.com/series/php-for-beginners)
- [PHP Coding Style Guide (PSR-2)](https://www.php-fig.org/psr/psr-2/)
- [Laravel video training series](https://laracasts.com/series/laravel-from-scratch-2018)
- [Official Laravel Documentation (v5.8)](https://laravel.com/docs/5.8)
- [Laravel Best Practices (mainly reference for naming conventions)](http://www.laravelbestpractices.com/)

# Get started with local development

### Preliminary setup

- Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
  - **If you're on Windows START VirtualBox AS ADMINISTRATOR**
- Install Vagrant: https://www.vagrantup.com/downloads.html
  - **If you're on Windows START Vagrant AS ADMINISTRATOR** i.e. run `vagrant up` in a shell that was started as administrator
- Create a new directory where you want to handle local development (I'll use the tilde ("~") symbol to represent this directory going forward)
- Open a command line at that new directory (the one we're calling "~").
- Clone the repo using the following command:

```git clone https://github.com/mattpearce85/local-php7.git .``` _you can download Git here if you don't already have it: https://git-scm.com/downloads_

- Now that we have the local environment repository on our machine we can execute the following commands:

```vagrant up``` _this will take a few minutes the first time..._

```vagrant ssh``` _this opens an ssh command line within the virtual machine_

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

- Execute the following commands to start up the local server resources

```cd /vagrant``` _/vagrant is mapped to the directory you ran "vagrant up" in (aka "~"), it also houses your web root and everything else_

```sudo docker-compose up -d``` _this will take a few minutes the first time..._

- If you want to shut down the local server resources, execute the following command

```sudo docker-compose down```

# Working with plain PHP

### Running PHP in the command line

- Make sure your local server resources are running using the `docker-compose` command above
- If you're not ssh'd into vagrant, open a command line where you cloned the repo and run the following command:

```vagrant ssh```

- Now you're logged into the vagrant virtual machine, but PHP7 is running within Docker container on our virtual machine, so we need to run another command to get to the command line _inside_ the PHP7 Docker container. It's like command line Inception!

```sudo docker exec -it php7 bash```

- Now we've jumped into the virtual machine, and jumped deeper still into the PHP7 Docker container. We should be ready to run PHP scripts from the command-line. For example, execute the following command to run our plain PHP file:

```php php7/plain-php/index.php```

- This command runs the PHP compiler on the specified file. In this case, the file just outputs some HTML code. The command line doesn't interpret HTML, so it's just plain text. How about running it in a web browser?

### Running PHP in the web browser

- Make sure your local server resources are running using the docker-compose command above
- Open your web browser to `http://plain-php.localhost/index.php`
- Let's edit that PHP code... Open the following file from the cloned repo in your IDE or a text editor. It will be somewhere like: `~/webroot/php7/plain-php/index.php` 
- Make some changes, save the file, and then refresh your web browser. Do you see your changes? Good!
- Now it's time to start learning PHP. Check out the [PHP video training series](https://laracasts.com/series/php-for-beginners)

# Working with Laravel

### Creating a new Laravel application

- Start a shell prompt in the PHP7 service (must be ssh'd into vagrant):

```sudo docker exec -it php7 bash```

- Navigate to the webroot for php7 code:

```cd /var/www/html/php7```

- Create the new laravel project

```composer create-project --prefer-dist laravel/laravel projectname```

- Navigate to the project directory and install the front-end dependencies

```cd projectname```

```npm install```

- Compile the front-end resources

```npm run dev``` _this generates flattened versions of your CSS and JS_

- Back out of the PHP7 container

```exit```

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
- The database is now ready, lets add the new credentials to the Laravel settings file. In your local IDE open the `.env` file for your project. It will be something like `~/webroot/php7/projectname/.env` (you might have to show hidden files to see it)
- In the `.env` file set `DB_DATABASE` and `DB_USERNAME` equal to the MySQL database name you just created like projectname, and paste in the password you generated a minute ago in phpMyAdmin. Also, set `DB_HOST` equal to `mysql`, that's the name of the docker service running MySQL.
- All done, your application will now use the new database.
- Now it's time to start learning Laravel. Check out the [Laravel video training series](https://laracasts.com/series/laravel-from-scratch-2018)

### Some Laravel-specific commands you'll use regularly

- Getting to the a command line for your project

```sudo docker exec -it php7 bash``` _start a shell prompt in the PHP7 service (must be ssh'd into vagrant)_

- Change to your projects directory, it will be something like:

```cd /var/www/html/php7/projectname```

- Compile CSS and JS assets one time

```npm run dev```

- Watch CSS and JS files for changes, and then auto-compile them

```npm run watch``` _press ctrl+c to stop watching for changes_

- Scaffolding of authorization feature

```php artisan make:auth``` _creates Laravel code needed for auth_

```php artisan migrate``` _runs any outstanding database migration scripts, in this case creating the "users" and "password_resets" tables```

# Other stuff

### Server-related commands you might need

- Reloading nginx (such as after updating a configuration file):

```sudo docker exec -it nginx sh``` _Start a shell prompt in the nginx service (must be ssh'd into vagrant)_

```nginx -s reload``` _reloads nginx_
