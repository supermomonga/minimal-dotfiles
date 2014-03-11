cd ~/

echo "\n"
echo "----------> Allow HTTP/HTTPS port"
sudo ufw allow http
sudo ufw allow https

echo "\n"
echo "----------> Allow FTPS port"
# sudo ufw allow ftp
sudo ufw allow ftps

echo "\n"
echo "----------> Allow SMTP port"
sudo ufw allow smtp

echo "\n"
echo "----------> Update packages"
sudo apt-get update

echo "\n"
echo "----------> Install dependencies"
sudo apt-get install -y \
  apache2 \
  vsftpd \
  mysql-server \
  php5 \
  libapache2-mod-php5 \
  php5-mysql \
  php5-json \
  php5-mcrypt \
  php5-gd \
  php5-mhash \
  php5-curl

echo "\n"
echo "----------> Configure apache2 virtual hosts"

echo "\n"
echo "----------> Configure FTP/FTPS server"
# uncomment /etc/vsftpd.conf
#local_enable=YES
#write_enable=YES

#chroot_local_user=YES
#chroot_list_enable=YES
#chroot_list_file=/etc/vsftpd.chroot_list

#ls_recurse_enable=YES

#add following lines
#local_root=sites
#use_localtime=YES
