echo "Please input domain name:"
read DOMAIN


cd /usr/share/ssl-cert/

echo "\n"
echo "----------> Make random phrase"
openssl sha512 /usr/bin/* > rand.dat

echo "\n"
echo "----------> Make private key"
openssl genrsa -rand ./rand.dat -des3 2048 -out $DOMAIN.key

echo "\n"
echo "----------> Make CSR"
echo "-> e.g.)"
echo "-> Country        : JP"
echo "-> State          : Tokyo"
echo "-> Locality name  : Chuo-Ku"
echo "-> Org name       : My Comp.ltd"
echo "-> Org unit name  : System"
echo "-> Common name    : example.com"
echo "-> Email          : "
echo "-> challenge pass : "
echo "-> optional name  : "
openssl req -new -key $DOMAIN.key -out $DOMAIN.csr

echo "\n"
echo "----------> Done!"
echo "-> Use this CSR to get cert and intermediate cert"
echo "-> and put them into here."
echo "->  example.com.crt"
echo "->  example.com.inter.crt"
