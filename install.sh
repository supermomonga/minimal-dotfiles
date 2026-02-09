#!/bin/sh
set -e

REPO_URL="https://raw.githubusercontent.com/supermomonga/minimal-dotfiles/master/install.sh"

# Helper: append a line to a file only if it's not already present
ensure_line() {
    grep -qxF "$1" "$2" 2>/dev/null || echo "$1" >> "$2"
}

# ============================================================
# Root mode: system provisioning
# ============================================================
if [ "$(id -u)" -eq 0 ]; then
    USERNAME="${1:-main}"

    echo ""
    echo "=========> Running as root. Setting up user: $USERNAME"

    echo ""
    echo "----------> Installing sudo"
    if ! command -v sudo >/dev/null 2>&1; then
        apt install -y sudo
    else
        echo "            (already installed)"
    fi

    echo ""
    echo "----------> Creating user"
    if ! id "$USERNAME" >/dev/null 2>&1; then
        useradd -m -s /bin/bash "$USERNAME"
    else
        echo "            (user $USERNAME already exists)"
    fi

    echo ""
    echo "----------> Adding user to sudo group"
    if ! id -nG "$USERNAME" | grep -qw sudo; then
        gpasswd -a "$USERNAME" sudo
    else
        echo "            (already in sudo group)"
    fi

    echo ""
    echo "----------> Configuring passwordless sudo for sudo group"
    if [ ! -f /etc/sudoers.d/sudo-nopasswd ]; then
        echo '%sudo   ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/sudo-nopasswd
        chmod 0440 /etc/sudoers.d/sudo-nopasswd
    else
        echo "            (already configured)"
    fi

    echo ""
    echo "----------> Re-running script as $USERNAME for personal setup"
    SELF="$(readlink -f "$0" 2>/dev/null || true)"
    if [ -f "$SELF" ]; then
        cp "$SELF" /tmp/_install.sh
    else
        curl -fsSL "$REPO_URL" -o /tmp/_install.sh
    fi
    chmod +r /tmp/_install.sh
    su - "$USERNAME" -c "sh /tmp/_install.sh"
    rm -f /tmp/_install.sh

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
ensure_line 'shopt -s autocd' ~/.bash_profile
ensure_line 'shopt -s dotglob' ~/.bash_profile
ensure_line 'test -r ~/.bashrc && . ~/.bashrc' ~/.bash_profile
ensure_line 'export EDITOR=vim' ~/.bash_profile
ensure_line 'alias tn="tmux new -s main"' ~/.bash_profile
ensure_line 'alias ta="tmux a -t main"' ~/.bash_profile
ensure_line 'alias rl="source ~/.bashrc; source ~/.bash_profile"' ~/.bash_profile

echo ""
echo "----------> Install dotfiles"
if [ ! -d ~/dotfiles ]; then
    git clone https://github.com/supermomonga/minimal-dotfiles.git ~/dotfiles
else
    echo "            (~/dotfiles already exists, pulling latest)"
    git -C ~/dotfiles fetch origin
    git -C ~/dotfiles reset --hard origin/master
fi
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.inputrc ~/.inputrc

echo ""
echo "----------> Install mise"
if ! command -v mise >/dev/null 2>&1 && [ ! -x ~/.local/bin/mise ]; then
    curl https://mise.run | sh
else
    echo "            (already installed)"
fi
ensure_line 'eval "$(~/.local/bin/mise activate bash)"' ~/.bashrc
mkdir -p ~/.local/share/bash-completion/completions/
~/.local/bin/mise completion bash --include-bash-completion-lib > ~/.local/share/bash-completion/completions/mise

echo ""
echo "----------> Setup complete!"

