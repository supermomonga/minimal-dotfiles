cd ~/

echo "\n"
echo "----------> Update packages"
sudo apt-get update

echo "\n"
echo "----------> Optional AUFS filesystem support"
sudo apt-get install -y linux-image-extra-`uname -r`

echo "\n"
echo "----------> Add the Docker repository key to your local keychain"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

echo "\n"
echo "----------> Add the Docker repository to your apt sources list"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

echo "\n"
echo "----------> Update packages"
sudo apt-get update

echo "\n"
echo "----------> Install the lxc-docker package"
sudo apt-get install -y lxc-docker

echo "\n"
echo "Done! now try following command!"
echo "sudo docker run -i -t ubuntu /bin/bash"
