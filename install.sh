cd ~/

echo "\n\n"
echo "----------> Update packages"
sudo apt-get update && sudo apt-get upgrade

echo "\n\n"
echo "----------> Install common packages"
sudo apt-get install -y git zsh

echo "\n\n"
echo "----------> Configuring zsh"
curl https://raw.github.com/sindresorhus/pure/master/pure.zsh > pure.zsh
sudo ln -s "$PWD/pure.zsh" /usr/local/share/zsh/site-functions/prompt_pure_setup

echo "\n\n"
echo "----------> Install dotfiles"
git clone https://github.com/supermomonga/minimal-dotfiles.git dotfiles
ln -s ./dotfiles/.zshrc ./.zshrc
ln -s ./dotfiles/.vimrc ./.vimrc

echo "\n\n"
echo "----------> Change shell"
chsh -s /usr/bin/zsh
source ./.zshrc


