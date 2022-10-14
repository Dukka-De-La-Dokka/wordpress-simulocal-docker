# First WordPress for you!
No time and no motivation to study WordPress, but want to play with WordPress just for basic things.  
Then, this is the right place to start with.

## Preparation
* Ubuntu User : docker installation beforehand
* Windows User : WSL2 and docker desktop installation beforehand

## How to setup docker containers
1. Download the source code of this docker project, unzip, and rename the root directory to your favorite project name: e.g. `my-first-wp_CTNR`
2. Rename `.env.sample` to `.env`
3. Delete the file `./wordpress/html/delete-this-file.txt` (not necessary though)
4. You can go ahead this wordpress project without modifying anything in the .env file, but if you want to change any values including the database's table prefix, please modify .env file in the first place
5. Up all containers from your project's root directory (where docker-compose.yml exists)
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
    * Your Email : hoge@hoge.com
    * Search engine visibility : Check
    * Login as 'wp-user' for password 'wp-user'
8. If you want to change the default max file upload size, please replace .htaccess file with the one located at the wordpress folder (close wordpress browser prior to doing this action)
9. Next time you login, you will be directed to the wordpress regular top page. If you need to go to the admin console panel, use this url instead `http://localhost:8080/wp-admin`

## Version
* Current release : v1.0
* Dockerfile base image :
    * db container : FROM mysql
    * wordpress container : FROM wordpress:php8.1-apache
    * phpmyadmin container : FROM phpmyadmin/phpmyadmin 

## For your local memo
