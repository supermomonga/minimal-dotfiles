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
    echo "----------> Installing sudo"
    apt-get update && apt-get install -y sudo

    echo ""
    echo "----------> Creating user"
    useradd -m -s /bin/bash "$USERNAME"

    echo ""
    echo "----------> Adding user to sudo group"
    gpasswd -a "$USERNAME" sudo

    echo ""
    echo "----------> Configuring passwordless sudo for sudo group"
    echo '%sudo   ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/sudo-nopasswd
    chmod 0440 /etc/sudoers.d/sudo-nopasswd

    echo ""
    echo "----------> Re-running script as $USERNAME for personal setup"
    SELF="$(readlink -f "$0")"
    su - "$USERNAME" -c "sh '$SELF'"

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
sudo apt install -y git unzip curl vim

echo ""
echo "----------> Setting default editor to vim.basic"
sudo update-alternatives --set editor /usr/bin/vim.basic

echo ""
echo "----------> Configuring bash"
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
echo "----------> Install mise"
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
mkdir -p ~/.local/share/bash-completion/completions/
~/.local/bin/mise completion bash --include-bash-completion-lib > ~/.local/share/bash-completion/completions/mise

echo ""
echo "----------> Setup complete!"

