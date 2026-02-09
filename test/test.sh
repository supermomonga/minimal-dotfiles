#!/bin/sh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

IMAGE_NAME="minimal-dotfiles-test"

echo "=== Building test image ==="
docker build -t "$IMAGE_NAME" -f "$SCRIPT_DIR/Dockerfile" "$PROJECT_DIR"

echo ""
echo "=== Testing root mode (full setup) ==="
docker run --rm "$IMAGE_NAME" sh -c '
  set -e

  echo "--- Running install.sh as root ---"
  sh /workspace/install.sh testuser

  echo ""
  echo "--- Verifying user creation ---"
  id testuser

  echo ""
  echo "--- Verifying sudoers config ---"
  test -f /etc/sudoers.d/sudo-nopasswd
  grep -q "NOPASSWD" /etc/sudoers.d/sudo-nopasswd

  echo ""
  echo "--- Verifying dotfiles symlinks ---"
  su - testuser -c "test -L ~/.vimrc"
  su - testuser -c "test -L ~/.tmux.conf"
  su - testuser -c "test -L ~/.inputrc"

  echo ""
  echo "--- Verifying .bash_profile ---"
  su - testuser -c "grep -q autocd ~/.bash_profile"
  su - testuser -c "grep -q EDITOR=vim ~/.bash_profile"

  echo ""
  echo "--- Verifying authorized_keys ---"
  su - testuser -c "test -f ~/.ssh/authorized_keys"
  su - testuser -c "grep -q ssh-ed25519 ~/.ssh/authorized_keys"

  echo ""
  echo "--- Verifying sshd password auth and root login disabled ---"
  grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config
  grep -q "^KbdInteractiveAuthentication no" /etc/ssh/sshd_config
  grep -q "^PermitRootLogin no" /etc/ssh/sshd_config

  echo ""
  echo "--- Verifying mise ---"
  su - testuser -c "test -f ~/.local/bin/mise"

  echo ""
  echo "=== All tests passed! ==="
'
