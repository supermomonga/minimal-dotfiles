cd ~/

echo "\n"
echo "----------> Update packages"
sudo apt-get update

echo "\n"
echo "----------> Install dependencies"
sudo apt-get install -y \
  build-essential \
  bison \
  libreadline6-dev \
  curl \
  git-core \
  zlib1g-dev \
  libssl-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  libxml2-dev \
  libxslt1-dev \
  autoconf \
  libncurses5-dev

echo "\n"
echo "----------> Clone rbenv, ruby-build repository"
cd ~/
git clone git://github.com/sstephenson/rbenv.git .rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
