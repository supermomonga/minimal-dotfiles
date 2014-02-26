cd ~/

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y git zsh

curl https://raw.github.com/sindresorhus/pure/master/pure.zsh > pure.zsh
sudo ln -s "$PWD/pure.zsh" /usr/local/share/zsh/site-functions/prompt_pure_setup

git clone git@github.com:supermomonga/minimal-dotfiles.git dotfiles

ln -s ./dotfiles/.zshrc ./.zshrc
ln -s ./dotfiles/.vimrc ./.vimrc

sudo chsh -s /bin/zsh

