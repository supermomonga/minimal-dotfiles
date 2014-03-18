#!/bin/sh

echo "\n"
echo "----------> Download archive"
wget http://downloads.ec-cube.net/src/eccube-2.13.1.tar.gz


echo "\n"
echo "----------> Extract archive"
tar xvzf ./eccube-2.13.1.tar.gz

echo "\n"
echo "----------> Rename / Remove files"
rm ./eccube-2.13.1.tar.gz
mv ./eccube-2.13.1/* ./
mv ./eccube-2.13.1/.* ./
rm -rf ./eccube-2.13.1
mv ./html ./public_html


echo "\n"
echo "----------> Set permission"
## EC CUBE set permission
chmod -R o+w public_html/install/temp/
chmod -R o+w public_html/user_data/
chmod -R o+w public_html/upload/
chmod -R o+w data/class/
chmod -R o+w data/cache/
chmod -R o+w data/logs/
chmod -R o+w data/downloads/
chmod -R o+w data/upload/
chmod o+w data/Smarty/
chmod o+w data/Smarty/config
chmod -R o+w data/Smarty/templates
chmod -R o+w data/Smarty/templates_c
chmod o+w public_html/
chmod o+w data/config/

echo "----------> Config .htaccess"
sed -i -e "s/#php_value\spost_max_size\s[0-9]\+M/php_value post_max_size 10M/" ./public_html/.htaccess
sed -i -e "s/php_value\supload_max_filesize\s[0-9]\+M/php_value upload_max_filesize 10M/" ./public_html/.htaccess




