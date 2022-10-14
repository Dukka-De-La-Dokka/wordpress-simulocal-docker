# First WordPress for you!
No time and no motivation to search for any WordPress servers, but want to play with WordPress just for basic things instantly.  
Then, this is the right place to start with.

## Preparation
* Ubuntu User : docker installation beforehand
* Windows User : WSL2 and docker desktop installation beforehand

## How to setup docker containers
1. Download the source code of this docker project, unzip, and rename the root directory to your favorite project name: e.g. `my-first-wp_CTNR`
2. Rename `.env.sample` to `.env`
3. Delete the file `./wordpress/html/delete-this-file.txt` (not necessary though)
4. You can go ahead this wordpress project without modifying anything in the .env file, but if you want to change any values including the database's table prefix, please modify .env file in the first place
5. Up all containers - execute command from your project's root directory (where docker-compose.yml exists)
```
docker compose up -d
```
6. Open your browser in order to connect to the wordpress and do initialize
```
http://localhost:8080
```
7. Please follow the installation procedure: e.g.
    * Language : English (USA)
    * Site Title : my-first-wp
    * Username : wp-user
    * Password : wp-user
    * Confirm Password : Check
    * Your Email : hoge-at-example.com
    * Search engine visibility : Check
    * Login as 'wp-user' for password 'wp-user'
8. If you want to change the default max file upload size, please replace .htaccess file with the one located at the wordpress folder (close wordpress browser prior to doing this action)
9. Next time you login, you will be directed to the wordpress regular top page. If you need to go to the admin console panel, use this url instead `http://localhost:8080/wp-admin`

## If you encountered REST API related Error (probably not necessary to do this action)
* Please modify `./fix.sh` script file to fill out the container name, then execute the script  (make sure all containers are being up)
```
bash ./fix.sh
```
* If you did `docker compose down`, please execute the script again after `docker compose up -d`
* Do not execute the script two consecutive times (if you did, please remove all containers and re-create)
* [Reference URL](https://stackoverflow.com/questions/43743894/local-wordpress-env-with-docker-compose-curl-error-7-failed-to-connect-to-loc)

## How to uninstall this wordpress project from your local machine
* If you want to uninstall this docker project, please do not forget to remove docker volume as well
```
docker volume ls
docker volume rm <project-name_mysql>
```

## Version
* Current release : v1.0
* Dockerfile base image :
    * db container : FROM mysql
    * wordpress container : FROM wordpress:php8.1-apache
    * phpmyadmin container : FROM phpmyadmin/phpmyadmin 

## For your local memo
