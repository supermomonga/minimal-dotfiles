cd ~/

echo "\n\n"
echo "----------> Update packages"
sudo apt update && sudo apt upgrade -y

echo "\n\n"
echo "----------> Install common packages"
sudo apt install -y build-essential sqlite3 libsqlite3-dev git unzip
sudo apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev

echo "\n\n"
echo "----------> Configuring bash"
echo 'eval "$(direnv hook bash)"' >> ~/.bash_profile
echo 'shopt -s autocd' >> ~/.bash_profile
echo 'shopt -s dotglob' >> ~/.bash_profile
echo 'test -r ~/.bashrc && . ~/.bashrc' >> ~/.bash_profile
echo 'export EDITOR=vim' >> ~/.bash_profile
echo 'alias tn="tmux new -s main"' >> ~/.bash_profile
echo 'alias ta="tmux a -t main"' >> ~/.bash_profile
echo 'alias rl="source ~/.bashrc; source ~/.bash_profile"' >> ~/.bash_profile

echo "\n\n"
echo "----------> Install dotfiles"
git clone https://github.com/supermomonga/minimal-dotfiles.git dotfiles
ln -s ./dotfiles/.vimrc ./.vimrc
ln -s ./dotfiles/.tmux.conf ./.tmux.conf
ln -s ./dotfiles/.inputrc ./.inputrc
