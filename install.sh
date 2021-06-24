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

echo "\n\n"
echo "----------> Install starship"
curl -fsSL https://starship.rs/install.sh | bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc

echo "\n\n"
echo "----------> Install asdf-vm"
sudo apt install curl git -y
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
echo ". \$HOME/.asdf/asdf.sh" >> ~/.bashrc
echo ". \$HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
