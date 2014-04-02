#!/bin/sh

echo -n "Please input domain name:"
read DOMAIN


cd /usr/share/ssl-cert/
echo $DOMAIN

echo "\n"
echo "----------> Make random phrase"
openssl sha512 /usr/bin/* > ./rand.dat

echo "\n"
echo "----------> Make private key"
openssl genrsa -rand ./rand.dat -des3 2048 > $DOMAIN.private.key.encripted
openssl rsa -in $DOMAIN.private.key.encripted -out $DOMAIN.private.key

echo "\n"
echo "----------> Make CSR"
echo "-> e.g.)"
echo "-> Country        : JP"
echo "-> State          : Tokyo"
echo "-> Locality name  : Otaku"
echo "-> Org name       : My Comp.ltd"
echo "-> Org unit name  : System"
echo "-> Common name    : example.com"
echo "-> Email          : admin@example.com"
echo "-> challenge pass : "
echo "-> optional name  : "
openssl req -new -key $DOMAIN.private.key -out $DOMAIN.csr

echo "\n"
echo "----------> Make empty public,intermediate crt files"
touch $DOMAIN.public.crt
touch $DOMAIN.intermediate.crt


echo "\n"
echo "----------> Done!"
echo "-> Use this CSR to get cert and intermediate cert"
echo "-> and put them into here."
echo "->  example.com.crt"
echo "->  example.com.inter.crt"
