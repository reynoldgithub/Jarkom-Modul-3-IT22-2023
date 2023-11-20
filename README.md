# Jarkom-Modul-3-IT22-2023

## Anggota:
1. Reynold Putra Merdeka - 50272110
2. Rakha Aldo Nirwasita - 5027211054

# Laporan Resmi

### Topologi
<img width="10000" alt="image" src="https://github.com/reynoldgithub/Jarkom-Modul-3-IT22-2023/assets/103549279/45f12296-f286-408d-a6ba-80e2c812d052">


### Config
- **Aura (DHCP Relay)**
```
auto eth0
iface eth0 inet dhcp

up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.244.0.0/16

auto eth1
iface eth1 inet static
	address 192.244.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.244.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.244.3.1
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.244.4.1
	netmask 255.255.255.0

```
- **Himmel (DHCP Server)**
```
auto eth0
iface eth0 inet static
	address 192.244.1.2
	netmask 255.255.255.0
	gateway 192.244.1.1
```
- **Heiter (DNS Server)**
```
auto eth0
iface eth0 inet static
	address 192.244.1.3
	netmask 255.255.255.0
	gateway 192.244.1.1
```
- **Denken (Database Server)**
```
auto eth0
iface eth0 inet static
	address 192.244.2.2
	netmask 255.255.255.0
	gateway 192.244.2.1
```
- **Eisen (Load Balancer)**
```
auto eth0
iface eth0 inet static
	address 192.244.2.3
	netmask 255.255.255.0
	gateway 192.244.2.1
```
- **Frieren (Laravel Worker)**
```
auto eth0
iface eth0 inet dhcp

hwaddress ether b6:f2:51:7a:32:62
```
- **Flamme (Laravel Worker)**
```
auto eth0
iface eth0 inet dhcp

hwaddress ether 2a:b3:aa:15:c3:ab
```
- **Fern (Laravel Worker)**
```
auto eth0
iface eth0 inet dhcp

hwaddress ether ea:3b:23:a4:f0:e3
```
- **Lawine (PHP Worker)**
```
auto eth0
iface eth0 inet dhcp

hwaddress ether 5e:9b:a1:32:f6:39

```
- **Linie (PHP Worker)**
```
auto eth0
iface eth0 inet dhcp

hwaddress ether 9a:1e:9d:45:b0:d3
```
- **Lugner (PHP Worker)**
```
auto eth0
iface eth0 inet dhcp

hwaddress ether 7a:26:32:b3:56:eb
```
- **Revolte, Richter, Sein, dan Stark (Client)**
```
auto eth0
iface eth0 inet dhcp
```




### Sebelum Memulai 
setiap node, kita inisiasi pada `.bashrc` menggunakan `nano`

- DNS Server
  ```sh
  echo 'nameserver 192.244.122.1' > /etc/resolv.conf
  apt-get update
  apt-get install bind9 -y  
  ```
- DHCP Server
  ```sh
  echo 'nameserver 192.244.122.1' > /etc/resolv.conf
  apt-get update
  apt install isc-dhcp-server -y
  ```
- DHCP Relay
  ```sh
  apt-get update
  apt install isc-dhcp-relay -y
  ```
- Database Server
  ```sh
  echo 'nameserver 192.244.122.1' > /etc/resolv.conf
  apt-get update
  apt-get install mariadb-server -y
  service mysql start

  Lalu jangan lupa untuk mengganti [bind-address] pada file /etc/mysql/mariadb.conf.d/50-server.cnf menjadi 0.0.0.0 dan jangan lupa untuk melakukan restart mysql kembali
  ```
- Load Balancer
  ```sh
  echo 'nameserver 192.244.122.1' > /etc/resolv.conf
  apt-get update
  apt-get install apache2-utils -y
  apt-get install nginx -y
  apt-get install lynx -y

  service nginx start
  ```
- Worker PHP
  ```sh
  echo 'nameserver 192.244.122.1' > /etc/resolv.conf
  apt-get update
  apt-get install nginx -y
  apt-get install wget -y
  apt-get install unzip -y
  apt-get install lynx -y
  apt-get install htop -y
  apt-get install apache2-utils -y
  apt-get install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip -y

  service nginx start
  service php7.3-fpm start
  ```
- Worker Laravel
  ```sh
  echo 'nameserver 192.244.122.1' > /etc/resolv.conf
  apt-get update
  apt-get install lynx -y
  apt-get install mariadb-client -y
  # Test connection from worker to database
  # mariadb --host=192.244.2.2 --port=3306   --user=kelompokit22 --password=passwordit22 dbkelompokit22 -e "SHOW DATABASES;"
  apt-get install -y lsb-release ca-certificates a   apt-transport-https software-properties-common gnupg2
  curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
  sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
  apt-get update
  apt-get install php8.0-mbstring php8.0-xml php8.0-cli   php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
  apt-get install nginx -y

  service nginx start
  service php8.0-fpm start
  ```
- Client
  ```sh
  apt update
  apt install lynx -y
  apt install htop -y
  apt install apache2-utils -y
  apt-get install jq -y
  ```

## Soal 1 
>Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

Pertama kita perlu mempersiapkan konfigurasi topologi dan [setup](#sebelum-memulai) seperti aturan diatas. Selanjutnya untuk kebutuhan testing, kita perlu menambahkan register domain berupa ``riegel.canyon.it22.com`` untuk worker Laravel dan granz.channel.it22.com untuk worker PHP yang mengarah pada worker dengan IP ``192.244.x.1``. Karena pada konfirgurasi topologi sebelumnya seluruh worker sudah menggunakan DHCP, maka kita perlu modifikasi sedikit pada node ``Lugner`` dan ``Fern`` seperti dibawah ini
- **Lugner (PHP Worker)**
```
auto eth0
iface eth0 inet static
	address 192.244.3.1
	netmask 255.255.255.0
	gateway 192.244.3.0
```
- **Fern (Laravel Worker)**
```
auto eth0
iface eth0 inet static
	address 192.244.4.1
	netmask 255.255.255.0
	gateway 192.244.4.0
```

Selanjutnya pada DNS Server (Heiter), kita perlu menjalankan command dibawah ini

### Script
```sh
echo 'zone "riegel.canyon.it22.com" {
    type master;
    file "/etc/bind/sites/riegel.canyon.it22.com";
};

zone "granz.channel.it22.com" {
    type master;
    file "/etc/bind/sites/granz.channel.it22.com";
};

mkdir -p /etc/bind/sites
cp /etc/bind/db.local /etc/bind/sites/riegel.canyon.it22.com
cp /etc/bind/db.local /etc/bind/sites/granz.channel.it22.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.it22.com. root.riegel.canyon.it22.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.it22.com.
@       IN      A       192.244.2.3     ; IP LB
www     IN      CNAME   riegel.canyon.it22.com.' > /etc/bind/sites/riegel.canyon.it22.com

echo '
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.it22.com. root.granz.channel.it22.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.it22.com.
@       IN      A       192.244.2.3     ; IP LB
www     IN      CNAME   granz.channel.it22.com.' > /etc/bind/sites/granz.channel.it22.com

echo 'options {
      directory "/var/cache/bind";

      forwarders {
              192.244.122.1;
      };

      // dnssec-validation auto;
      allow-query{any;};
      auth-nxdomain no;    
      listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

service bind9 start
```
### Result



## Soal 2
>Semua CLIENT harus menggunakan konfigurasi dari DHCP Server. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80

Sebelum mengerjakan perlu untuk melakukan [setup](#sebelum-memulai) untuk DHCP Server terlebih dahulu. Selanjutnya kita perlu menjalankan command dibawah ini pada DHCP Server
### Script 
```sh
echo 'subnet 192.244.1.0 netmask 255.255.255.0 {
}

subnet 192.244.2.0 netmask 255.255.255.0 {
}

subnet 192.244.3.0 netmask 255.255.255.0 {
    range 192.244.3.16 192.244.3.32;
    range 192.244.3.64 192.244.3.80;
    option routers 192.244.3.0;
}' > /etc/dhcp/dhcpd.conf
```

## Soal 3 
>Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168

Selanjutnya kita perlu menambahkan beberapa konfigurasi baru untuk switch4 dengan menjalankan command dibawah ini

### Script 
```sh
echo 'subnet 192.244.1.0 netmask 255.255.255.0 {
}

subnet 192.244.2.0 netmask 255.255.255.0 {
}

subnet 192.244.3.0 netmask 255.255.255.0 {
    range 192.244.3.16 192.244.3.32;
    range 192.244.3.64 192.244.3.80;
    option routers 192.244.3.0;
}

subnet 192.244.4.0 netmask 255.255.255.0 {
    range 192.244.4.12 192.244.4.20;
    range 192.244.4.160 192.244.4.168;
    option routers 192.244.4.0;
} ' > /etc/dhcp/dhcpd.conf
```

## Soal 4 
>Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut

kita akan menambahkan beberapa konfigurasi seperti ``option broadcast-address`` dan ``option domain-name-server`` agar dapat DNS yang telah disiapkan sebelumnya dapat digunakan

### Script
```sh 
subnet 192.244.3.0 netmask 255.255.255.0 {
    ...
    option broadcast-address 192.244.3.255;
    option domain-name-servers 192.244.1.2;
    ...
}

subnet 192.244.4.0 netmask 255.255.255.0 {
    option broadcast-address 192.244.4.255;
    option domain-name-servers 192.244.1.2;
} 
```

Lalu gunakan ``shell`` script sebagai berikut

```sh
echo 'subnet 192.244.1.0 netmask 255.255.255.0 {
}

subnet 192.244.2.0 netmask 255.255.255.0 {
}

subnet 192.244.3.0 netmask 255.255.255.0 {
    range 192.244.3.16 192.244.3.32;
    range 192.244.3.64 192.244.3.80;
    option routers 192.244.3.0;
    option broadcast-address 192.244.3.255;
    option domain-name-servers 192.244.1.2;
}

subnet 192.244.4.0 netmask 255.255.255.0 {
    range 192.244.4.12 192.244.4.20;
    range 192.244.4.160 192.244.4.168;
    option routers 192.244.4.0;
    option broadcast-address 192.244.4.255;
    option domain-name-servers 192.244.1.2;
} ' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server start
```

Selanjutnya kita perlu untuk melakukan [setup](#sebelum-memulai) untuk DHCP Relay terlebih dahulu. Selanjutnya kita perlu menjalankan command dibawah ini pada DHCP Relay
```sh
echo '# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="192.244.1.1"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth1 eth2 eth3 eth4"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""' > /etc/default/isc-dhcp-relay

service isc-dhcp-relay start 
```

Lalu pada file ``/etc/sysctl.conf`` lakukan uncommented pada ``net.ipv4.ip_forward=1``

Terakhir jangan lupa untuk restart seluruh client

## Soal 5
>Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit

Kita perlu menggunakan bantuan fungsi ``default-lease-time`` dan ``max-lease-team`` dimana satuannya adalah detik.

Karena pada ``switch3`` dapat meminjamkan IP selama ``3 Menit`` dan ``Switch4`` dapat meminjamkan IP selama ``12 Menit``. Sehingga pada ``Switch3`` membutuhkan waktu ``180 s`` dan ``Switch4`` membutuhkan waktu ``720 s`` dan untuk ``max-lease-time`` nya adalah ``96 menit`` dimana akan menjadi ``5760 s``
 
Selanjutnya kita perlu menambahkan beberapa konfigurasi baru untuk mengatur leasing time pada switch3 dan switch4 sesuai dengan aturan soal. Kita dapat menjalankan command berikut pada DHCP Server

### Script
```sh
echo 'subnet 192.244.1.0 netmask 255.255.255.0 {
}

subnet 192.244.2.0 netmask 255.255.255.0 {
}

subnet 192.244.3.0 netmask 255.255.255.0 {
    range 192.244.3.16 192.244.3.32;
    range 192.244.3.64 192.244.3.80;
    option routers 192.244.3.0;
    option broadcast-address 192.244.3.255;
    option domain-name-servers 192.244.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.244.4.0 netmask 255.255.255.0 {
    range 192.244.4.12 192.244.4.20;
    range 192.244.4.160 192.244.4.168;
    option routers 192.244.4.0;
    option broadcast-address 192.244.4.255;
    option domain-name-servers 192.244.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}

service isc-dhcp-server restart
```

## Soal 6
> Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3. (6)

Sebelum mengerjakan perlu untuk melakukan [setup](#sebelum-memulai) terlebih dahulu pada **seluruh PHP Worker**. Jika sudah, silahkan untuk melakukan konfigurasi tambahan sebagai berikut untuk melakukan download dan unzip menggunakan command ``wget``
```sh
wget -O '/var/www/granz.channel.it22.com' 'https://drive.google.com/u/0/uc?id=1ViSkRq7SmwZgdK64eRbr5Fm1EGCTPrU1&export=download'
unzip -o /var/www/granz.channel.it22.com -d /var/www/
rm /var/www/granz.channel.it22.com
mv /var/www/modul-3 /var/www/granz.channel.it22.com
```

### Script
Setelah melakukan download dan unzip. Sekarang kita bisa melakukan konfigurasi pada ``nginx`` sebagai berikut:
```sh 
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/granz.channel.it22.com
ln -s /etc/nginx/sites-available/granz.channel.it22.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

echo 'server {
    listen 80;
    server_name _;

    root /var/www/granz.channel.it22.com;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.3-fpm.sock;  # Sesuaikan versi PHP dan socket
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}' > /etc/nginx/sites-available/granz.channel.it22.com

service nginx restart
```

### Result 
Jalankan Perintah ``lynx localhost`` pada masing-masing worker dan hasilnya akan sebagai berikut:

``Pada Lawine``


``Pada Linie``


``Pada Lugner``



## Soal 7
> Kepala suku dari Bredt Region memberikan resource server sebagai berikut: Lawine, 4GB, 2vCPU, dan 80 GB SSD. Linie, 2GB, 2vCPU, dan 50 GB SSD. Lugner 1GB, 1vCPU, dan 25 GB SSD. Aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second. (7)

Sebelum mengerjakan perlu untuk melakukan [setup](#sebelum-memulai) terlebih dahulu. Setelah melakukan konfigurasi diatas, sekarang lakukan konfigurasi ``Load Balancing`` pada node ``Eisen`` sebagai berikut 

### Script
Sebelum melakukan setup soal 7. Buka kembali Node ``DNS Server`` dan arahkan ``domain`` tersebut pada ``IP Load Balancer Eisen``

```sh
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.it22.com. root.riegel.canyon.it22.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.it22.com.
@       IN      A       192.244.2.3     ; IP LB Eisen
www     IN      CNAME   riegel.canyon.it22.com.' > /etc/bind/sites/riegel.canyon.it22.com

echo '
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.it22.com. root.granz.channel.it22.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.it22.com.
@       IN      A       192.244.2.3     ; IP LB Eisen
www     IN      CNAME   granz.channel.it22.com.' > /etc/bind/sites/granz.channel.it22.com
```

Lalu kembali ke node ``Eisen`` dan lakukan konfigurasi pada nginx sebagai berikut

```sh 
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

echo 'upstream worker {
    server 192.244.3.2;
    server 192.244.3.3;
    server 192.244.3.4;
}

server {
    listen 80;
    server_name granz.channel.it22.com www.granz.channel.it22.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
    }
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart
```

Setelah itu lakukan [konfigurasi](#sebelum-memulai) pada salah satu client. Disini kami melakukan konfigurasi pada client ``Revolte``

### Result
Jalankan perintah berikut pada client ``Revolte``
```sh
ab -n 1000 -c 100 http://www.granz.channel.it22.com/ 
```

dan akan mendapatkan hasil seperti berikut 

img

dan waktu yang dihasilkan adalah  ``Requests per second:    2009.78 [#/sec] (mean)`` serta yang dibutuhkan adalah sebagai berikut 

img

## Soal 8
> Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut: 1. Nama Algoritma Load Balancer; 2. Report hasil testing pada Apache Benchmark; 3.Grafik request per second untuk masing masing algoritma; 4. Analisis

Sebelum mengerjakan perlu untuk melakukan [setup](#sebelum-memulai) terlebih dahulu. Selebihnya untuk konfigurasinya sama dengan [Soal 7](#Soal-7)

Untuk laporan ``grimoire`` nya kami membuatnya di google.docs pada [link](https://docs.google.com/document/d/1vwAJHfr9x8KeSgheB2WOMpXURyXFwldQ1S4w4-aM0jg/edit?usp=sharing) ini.

### Script
Jalankan command berikut pada client ``Revolte``
```sh
ab -n 200 -c 10 http://www.granz.channel.it22.com/ 
```

### Result 

**Round Robin**

img

**Least-connection**

img

**IP Hash**

img

**Generic Hash**

img

**Grafik**

img

## Soal 9
> Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire. (9)

Sebelum mengerjakan perlu untuk melakukan [setup](#sebelum-memulai) terlebih dahulu. Setelah melakukan setup pada node ``Eisen`` sekarang lakukan testing pada load balancer yang telah dibuat sebelumnya. Yang menjadi pembeda adalah kita harus melakukan testing menggunakan ``1 worker``, ``2 worker``, dan ``3 worker``. 

### Script
Jalankan command berikut pada client ``Revolte``
```sh
ab -n 100 -c 10 http://www.granz.channel.it22.com/ 
```

### Result

**3 Worker**

img

> Request per second 3104.92 [#/sec] (mean)

**2 Worker**

img

> Request per second 3332.89 [#/sec] (mean)

**1 Worker**

img

> Request per second 2762.43 [#/sec] (mean)

**Grafik**

img

## Soal 10
> Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/rahasisakita/ 

Sebelum mengerjakan perlu untuk melakukan [setup](#sebelum-memulai) terlebih dahulu. Setelah itu, lakukan beberapa konfigurasi sebagai berikut

### Script
```sh 
mkdir /etc/nginx/rahasisakita
htpasswd -c /etc/nginx/rahasisakita/htpasswd netics
```

Lalu, masukkan passwordnya ``ajkit22``

Jika sudah memasukkan ``password`` dan ``re-type password``. Sekarang bisa dicoba dengan menambahkan command berikut pada setup nginx.

```sh
auth_basic "Restricted Content";
auth_basic_user_file /etc/nginx/rahasisakita/htpasswd;
```

### Result
Jadi, ketika kita mengakses kembali url ``http://www.granz.channel.it22.com/`` akan muncul halaman seperti ini apabila berhasil autentikasi

img
