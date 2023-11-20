# JARKOM Modul 3 IT 22

## Soal 11
Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id. 

```conf
# Eisen
# /etc/nginx/sites-enabled/default
...

server {
    ...

    location /its/ {
        proxy_pass https://www.its.ac.id/;
    }

    ...
}

```

## Soal 12
Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].3.69, [Prefix IP].3.70, [Prefix IP].4.167, dan [Prefix IP].4.168. 
```conf
# Eisen
# /etc/nginx/sites-enabled/default
...

server {
    ...

    deny all;
    allow 192.244.3.69;
    allow 192.244.3.70;
    allow 192.244.4.167;
    allow 192.244.4.168;
    ...
}

```

## Soal 13
Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren, Flamme, dan Fern

Script untuk auto create database
```sql
-- ~/mysql.sql
CREATE USER IF NOT EXISTS 'kelompokit22'@'%' IDENTIFIED BY 'passwordit22';
CREATE USER IF NOT EXISTS 'kelompokit22'@'localhost' IDENTIFIED BY 'passwordit22';
CREATE DATABASE IF NOT EXISTS dbkelompokit22;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit22'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit22'@'localhost';
FLUSH PRIVILEGES;
```

Allowing database access from outside
```conf
# /etc/mysql/my.conf
[client-server]

# Import all .cnf files from configuration directory
!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mariadb.conf.d/

[mysqld]
skip-networking=0
skip-bind-address

```

```bash
# ~/script.sh

apt-get update
apt-get install mariadb-server -y

service mysql start

mysql < ~/mysql.sql

cp ~/my.cnf /etc/mysql/my.cnf

service mysql restart

```

## Soal 14
Frieren, Flamme, dan Fern memiliki Riegel Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer 

Script untuk install php dan composer
```bash
apt-get update
apt-get install mariadb-client

apt-get install nginx -y

apt-get install git -y

apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
apt-get update
apt-get install php8.1-mbstring php8.1-xml php8.1-cli php8.1-common php8.1-intl php8.1-opcache php8.1-readline php8.1-mysql php8.1-fpm php8.1-curl unzip wget -y
wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer
```

Nginx config for laravel
```bash
server {
    listen 80;

    root /var/www/laravel-praktikum-jarkom/public;

    index index.php index.html index.htm;
    server_name _;

    location / {
            try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
            deny all;
    }

    error_log /var/log/nginx/laravel_rest_error.log;
    access_log /var/log/nginx/laravel_rest_access.log;
}
```

```bash
git clone https://github.com/martuafernando/laravel-praktikum-jarkom.git

cd ~/laravel-praktikum-jarkom
composer install
php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate
php artisan jwt:secret
cp -r ~/laravel-praktikum-jarkom /var/www
service php8.1-fpm start
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage
cp -r ~/nginx /etc
service nginx restart

```


## Soal 15
Testing 100 Request dengan 10 request/second
POST /auth/register 

```
# register.json
{"username":"user2", "password":"password2"}
```

Testing command
```bash
ab -n 100 -c 10 -p register.json -T application/json http://riegel.canyon.it22.com/api/auth/register > register.log
```

Hasil log
99 Request error karna username tidak unique
```log
Benchmarking riegel.canyon.it22.com (be patient).....done


Server Software:        nginx/1.14.2
Server Hostname:        riegel.canyon.it22.com
Server Port:            80

Document Path:          /api/auth/register
Document Length:        471 bytes

Concurrency Level:      10
Time taken for tests:   5.733 seconds
Complete requests:      100
Failed requests:        99
   (Connect: 0, Receive: 0, Length: 99, Exceptions: 0)
Non-2xx responses:      99
Total transferred:      34914 bytes
Total body sent:        20600
HTML transferred:       5718 bytes
Requests per second:    17.44 [#/sec] (mean)
Time per request:       573.254 [ms] (mean)
Time per request:       57.325 [ms] (mean, across all concurrent requests)
Transfer rate:          5.95 [Kbytes/sec] received
                        3.51 kb/s sent
                        9.46 kb/s total

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.2      0      11
Processing:    29  482 786.0    120    3363
Waiting:       29  482 786.0    119    3363
Total:         31  483 786.2    120    3366

Percentage of the requests served within a certain time (ms)
  50%    120
  66%    370
  75%    462
  80%    519
  90%   1694
  95%   2571
  98%   3353
  99%   3366
 100%   3366 (longest request)

```
## Soal 16
Testing 100 Request dengan 10 request/second
POST /auth/login

```
# login.json
{"username":"user", "password":"password"}
```

Testing command
```bash
ab -n 100 -c 10 -p login.json -T application/json http://riegel.canyon.it22.com/api/auth/login > login.json
```

Hasil log
```log
Server Software:        nginx/1.14.2
Server Hostname:        riegel.canyon.it22.com
Server Port:            80

Document Path:          /api/auth/login
Document Length:        345 bytes

Concurrency Level:      10
Time taken for tests:   16.057 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      62800 bytes
Total body sent:        20000
HTML transferred:       34500 bytes
Requests per second:    6.23 [#/sec] (mean)
Time per request:       1605.708 [ms] (mean)
Time per request:       160.571 [ms] (mean, across all concurrent requests)
Transfer rate:          3.82 [Kbytes/sec] received
                        1.22 kb/s sent
                        5.04 kb/s total

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   0.9      0       7
Processing:   187 1565 482.5   1567    2615
Waiting:      184 1565 482.6   1567    2615
Total:        187 1566 482.6   1567    2616
WARNING: The median and mean for the initial connection time are not within a normal deviation
        These results are probably not that reliable.

Percentage of the requests served within a certain time (ms)
  50%   1567
  66%   1775
  75%   1970
  80%   2081
  90%   2199
  95%   2292
  98%   2505
  99%   2616
 100%   2616 (longest request)
```

## Soal 17
Testing 100 Request dengan 10 request/second
GET /me

Testing command
```bash
ab -n 100 -c 10 -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vcmllZ2VsLmNhbnlvbi5pdDIyLmNvbS9hcGkvYXV0aC9yZWdpc3RlciIsImlhdCI6MTcwMDQ5MjA2OCwiZXhwIjoxNzAwNDk1NjY4LCJuYmYiOjE3MDA0OTIwNjgsImp0aSI6Imx5WGJoUEhwazViOUlFY2giLCJzdWIiOiIzIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.vULlgJs45eyYkpC3cur-8r2kD4zqQ4QEI9DH_dZMPlw" http://riegel.canyon.it22.com/api/me > get.log

```

Hasil log
```log
Server Software:        nginx/1.14.2
Server Hostname:        riegel.canyon.it22.com
Server Port:            80

Document Path:          /api/me
Document Length:        29 bytes

Concurrency Level:      10
Time taken for tests:   1.741 seconds
Complete requests:      100
Failed requests:        33
   (Connect: 0, Receive: 0, Length: 33, Exceptions: 0)
Non-2xx responses:      67
Total transferred:      34707 bytes
HTML transferred:       5804 bytes
Requests per second:    57.44 [#/sec] (mean)
Time per request:       174.085 [ms] (mean)
Time per request:       17.409 [ms] (mean, across all concurrent requests)
Transfer rate:          19.47 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    2   4.3      0      16
Processing:    21  164 139.4    119     541
Waiting:       16  163 139.5    118     541
Total:         21  165 139.7    120     541

Percentage of the requests served within a certain time (ms)
  50%    120
  66%    233
  75%    281
  80%    302
  90%    380
  95%    441
  98%    457
  99%    541
 100%    541 (longest request)
```


## Soal 18
Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur Riegel Channel maka implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Frieren, Flamme, dan Fern. 

```conf
upstream backend-laravel  {
        server 192.244.4.2;
        server 192.244.4.3;
        server 192.244.4.4;
}

server {
        listen 80;
        server_name riegel.canyon.it22.com;

        location / {
                proxy_pass              http://backend-laravel;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        Host $http_host;
        }

        location ~ /\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_laravel_error.log;
        access_log /var/log/nginx/lb_laravel_access.log;

}

```

## Soal 19

## Soal 20
Setup laravel nginx
```conf
upstream backend-laravel  {
        least_conn;
        server 192.244.4.2;
        server 192.244.4.3;
        server 192.244.4.4;
}

server {
        # auth_basic           "Administrator's Area";
        # auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;
        listen 80;
        server_name riegel.canyon.it22.com;


        # deny all;
        # allow 192.244.3.69;
        # allow 192.244.3.70;
        # allow 192.244.4.167;
        # allow 192.244.4.168;

        location / {
                proxy_pass              http://backend-laravel;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        Host $http_host;
        }

        location ~ /\.ht {
            deny all;
        }

        error_log /var/log/nginx/lb_laravel_error.log;
        access_log /var/log/nginx/lb_laravel_access.log;

}

```
Test script
```bash
ab -n 100 -c 10 -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vcmllZ2VsLmNhbnlvbi5pdDIyLmNvbS9hcGkvYXV0aC9yZWdpc3RlciIsImlhdCI6MTcwMDQ5MjA2OCwiZXhwIjoxNzAwNDk1NjY4LCJuYmYiOjE3MDA0OTIwNjgsImp0aSI6Imx5WGJoUEhwazViOUlFY2giLCJzdWIiOiIzIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.vULlgJs45eyYkpC3cur-8r2kD4zqQ4QEI9DH_dZMPlw" http://riegel.canyon.it22.com/api/me > get-ll.log
```
Log test

```log
Server Software:        nginx/1.14.2
Server Hostname:        riegel.canyon.it22.com
Server Port:            80

Document Path:          /api/me
Document Length:        29 bytes

Concurrency Level:      10
Time taken for tests:   1.592 seconds
Complete requests:      100
Failed requests:        0
Non-2xx responses:      100
Total transferred:      32100 bytes
HTML transferred:       2900 bytes
Requests per second:    62.82 [#/sec] (mean)
Time per request:       159.194 [ms] (mean)
Time per request:       15.919 [ms] (mean, across all concurrent requests)
Transfer rate:          19.69 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    2   5.4      0      24
Processing:    43  151  68.4    138     493
Waiting:       43  150  68.4    137     493
Total:         43  153  70.0    142     496

Percentage of the requests served within a certain time (ms)
  50%    142
  66%    164
  75%    172
  80%    191
  90%    237
  95%    308
  98%    373
  99%    496
 100%    496 (longest request)

```