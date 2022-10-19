# Run WordPress multiple site simultaneously via local docker
This wordpress docker project is made for running multiple site at the same time on your local machine.  
The difference between [regular version](https://github.com/Dukka-De-La-Dokka/wordpress-local-docker) and this version is whether the docker containers of all projects can run simultaneously or not.  
To be brief,
* If you need to develop your multiple wordpress sites without doing `docker compose stop` whenever you need to switch to another site, this repository gonna perfectly suits you
* If it is ok for you `docker compose stop` for the wordpress site 01 then `docker compose up -d` for the wordpress site 02 whenever switching the site, please go back to  [regular version](https://github.com/Dukka-De-La-Dokka/wordpress-local-docker) to enjoy your wordpress development life

## Preparation
* Ubuntu User : docker installation beforehand
* Windows User : WSL2 and docker desktop installation beforehand

## How to setup docker containers
1. Download the source code of this docker project, unzip, and rename the root directory to your favorite project name: e.g. `myblog1_CTNR`
2. Rename `.env.sample` to `.env`
3. Delete the file `./wordpress/html/delete-this-file.txt` (not necessary though)
4. Modify the IP value of `.env` file to set the 'Local Loopback Address' so that the each multiple wordpress site can recognize themselfves correctly  (I would recommend that you should change TABLE_PREFIX value as well depending on the each wordpress site title)

For the first wordpress site:
```
IP=127.0.0.1
```
For the second wordpress site:
```
IP=127.0.0.2
```
and so on....

5. Run all containers - execute command from your project's root directory (where `docker-compose.yml` exists)
```
docker compose up -d
```
6. Open your browser in order to connect to the wordpress and do initialize  

If the Loopback Address of your wordpress site is set to 127.0.0.1:
```
http://127.0.0.1
or
http://localhost
```
If the Loopback Address of your wordpress site is set to 127.0.0.2:
```
http://127.0.0.2
```
and so on....

7. Please follow the installation procedure: e.g.
    * Language : English (USA)
    * Site Title : myblog1
    * Username : wp-user
    * Password : wp-user
    * Confirm Password : Check
    * Your Email : hoge-at-example.com
    * Search engine visibility : Check
    * Login as 'wp-user' for password 'wp-user'
8. Repeat the same procedure from #1 to #7 for the each wordpress site 
* Next time you login, you will be directed to the wordpress regular top page. If you need to go to the admin console panel, use this url instead
```
http://<your_loopback_IP>/wp-admin
```

## How to connect to mysql database via phpMyAdmin
* Make sure all containers are being running, then access to the following url from your browser (if your loopback IP address is set to 127.0.0.1, then you can use `http://localhost:8080` alternatively)
```
http://<your_loopback_IP>:8080
```

## Change the existing Loopback IP Address to another IP Address afterwards (temporarily)
1. Please modify `.env` file of the target project
    * Change to the desired loopback address at IP
    * Remove two # at `WORDPRESS_WP_HOME` and `WORDPRESS_WP_SITEURL`
    * Set the desired loopback address for the value of `WORDPRESS_WP_HOME` and `WORDPRESS_WP_SITEURL`
2. Add the following definitions **right after**  `/* Add any custom values between this line and the "stop editing" line. */` line or **right before** `/* That's all, stop editing! Happy publishing. */` line of the target project's `./wordpress/html/wp-config.php` file (Do not care about the value 127.0.0.1 since this is only used if the values at `.env` file is set to empty)
```
/** The address where WordPress core files reside */
define( 'WP_HOME', getenv_docker('WORDPRESS_WP_HOME', 'http://127.0.0.1') );

/** The address for people to type in to reach WordPress */
define( 'WP_SITEURL', getenv_docker('WORDPRESS_WP_SITEURL', 'http://127.0.0.1') );
```
3. Reset all containers (unfortunately `docker compose restart` does not work somehow....)
```
docker compose stop
docker compose up -d
(or)
docker compose remove
docker compose up -d
```
* If the newly set loopback address gonna match the existing loopback address of the another site, please change that address as well

## Change the existing Loopback IP Address to another IP Address afterwards (permanently method 1)
1. Change to the desired loopback address at IP with `.env` file of the target project
2. Make sure that the target project's containers are being up, and run the following command in order to change the database

    * General command
    ```
    docker exec -i <db_container_name> mysql -u <user_name> -p<password> <database_name> -e "UPDATE <table_prefix>options SET option_value = 'http://<new_loopback_address>' WHERE option_name IN ('home', 'siteurl');"
    ```

    * Particular command
    ```
    docker exec -i myblog1-db-1 mysql -u local -plocal0000 wp_local_docker -e "UPDATE myblog1_options SET option_value = 'http://127.0.0.25' WHERE option_name IN ('home', 'siteurl');"
    ```
3. Reset all containers (unfortunately `docker compose restart` does not work somehow....)
```
docker compose stop
docker compose up -d
(or)
docker compose remove
docker compose up -d
```

## Change the existing Loopback IP Address to another IP Address afterwards (permanently method 2)
1. Please modify `.env` file of the target project
    * Change to the desired loopback address at IP
    * Remove two # at `WORDPRESS_WP_HOME` and `WORDPRESS_WP_SITEURL`
    * Set the desired loopback address for the value of `WORDPRESS_WP_HOME` and `WORDPRESS_WP_SITEURL`
2. Add the following update commands **after**  `require_once ABSPATH . 'wp-settings.php';` line of the target project's `./wordpress/html/wp-config.php` file (Do not care about the value 127.0.0.1 since this is only used if the values at `.env` file is set to empty)
```
update_option( 'home', getenv_docker('WORDPRESS_WP_HOME', 'http://127.0.0.1') );
update_option( 'siteurl', getenv_docker('WORDPRESS_WP_SITEURL', 'http://127.0.0.1') );
```
3. Reset all containers (unfortunately `docker compose restart` does not work somehow....)
```
docker compose stop
docker compose up -d
(or)
docker compose remove
docker compose up -d
```
4. Login with the new loopback address and go to the admin dashboard
5. Remove update commands from the `wp-config.php` file
6. Add two # at the beginning of `WORDPRESS_WP_HOME` and `WORDPRESS_WP_SITEURL` in the `.env` file

## How to uninstall this wordpress project from your local machine
* If you want to uninstall this docker project, please do not forget to remove the data volume, along with removing containers (`docker compose down`) and images (`docker rmi <repository names>`)
```
docker volume ls
docker volume rm <all-your-wordpress-sites_mysql>
```

## Others
* Wordpress container's user ID is currently set to 1000, this is for an easy access from your host machine. You may change this value to other numbers such as 2000 depending on your host machine's user ID. (But I am not sure if the IDs other than 1000 would work correctly....)
* If you want to change the default max file upload size, please add the following php parameters before `# BEGIN WordPress` sentence in the `.htaccess` file located at the wordpress's html root folder (close wordpress browser prior to doing this action)
```
php_value upload_max_filesize 512M
php_value post_max_size 512M
php_value memory_limit 512M
php_value max_execution_time 300
php_value max_input_time 300
```

## Version
* Current release : v1.5
* Dockerfile base image :
    * db container : `FROM mysql`
    * wordpress container : `FROM wordpress:php8.1-apache`
    * phpmyadmin container : `FROM phpmyadmin/phpmyadmin`

## For your local memo
