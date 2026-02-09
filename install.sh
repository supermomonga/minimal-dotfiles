#!/bin/sh
set -e

REPO_URL="https://raw.githubusercontent.com/supermomonga/minimal-dotfiles/master/install.sh"

# ============================================================
# Root mode: system provisioning
# ============================================================
if [ "$(id -u)" -eq 0 ]; then
    USERNAME="${1:-main}"

    echo ""
    echo "=========> Running as root. Setting up user: $USERNAME"

    echo ""
    echo "----------> Creating user"
    adduser "$USERNAME"

    echo ""
    echo "----------> Adding user to sudo group"
    gpasswd -a "$USERNAME" sudo

    echo ""
    echo "----------> Configuring passwordless sudo for sudo group"
    echo '%sudo   ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/sudo-nopasswd
    chmod 0440 /etc/sudoers.d/sudo-nopasswd

    echo ""
    echo "----------> Setting default editor to vim.basic"
    update-alternatives --set editor /usr/bin/vim.basic

    echo ""
    echo "----------> Re-running script as $USERNAME for personal setup"
    su - "$USERNAME" -c "curl -fsSL $REPO_URL | sh"

    echo ""
    echo "=========> Done! Log in as $USERNAME to get started."
    exit 0
fi

# ============================================================
# Non-root mode: personal environment setup
# ============================================================

cd ~/

echo ""
echo "----------> Update packages"
sudo apt update && sudo apt upgrade -y

echo ""
echo "----------> Install common packages"
sudo apt install -y git unzip curl

echo ""
echo "----------> Configuring bash"
echo 'eval "$(direnv hook bash)"' >> ~/.bash_profile
echo 'shopt -s autocd' >> ~/.bash_profile
echo 'shopt -s dotglob' >> ~/.bash_profile
echo 'test -r ~/.bashrc && . ~/.bashrc' >> ~/.bash_profile
echo 'export EDITOR=vim' >> ~/.bash_profile
echo 'alias tn="tmux new -s main"' >> ~/.bash_profile
echo 'alias ta="tmux a -t main"' >> ~/.bash_profile
echo 'alias rl="source ~/.bashrc; source ~/.bash_profile"' >> ~/.bash_profile

echo ""
echo "----------> Install dotfiles"
git clone https://github.com/supermomonga/minimal-dotfiles.git dotfiles
ln -s ./dotfiles/.vimrc ./.vimrc
ln -s ./dotfiles/.tmux.conf ./.tmux.conf
ln -s ./dotfiles/.inputrc ./.inputrc

echo ""
echo "----------> Install asdf-vm"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
echo ". \$HOME/.asdf/asdf.sh" >> ~/.bashrc
echo ". \$HOME/.asdf/completions/asdf.bash" >> ~/.bashrc

echo ""
echo "----------> Setup complete!"
