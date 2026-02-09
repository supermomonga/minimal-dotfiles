#!/bin/sh
set -e

# This script must be run via sudo.
# It adds the calling user to the sudo group and enables passwordless sudo.
#
# Usage: sudo sh enable_sudoer.sh

if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run via sudo." >&2
    exit 1
fi

if [ -z "$SUDO_USER" ]; then
    echo "Error: SUDO_USER is not set. Run this script via sudo, not as root directly." >&2
    exit 1
fi

USERNAME="$SUDO_USER"

echo ""
echo "----------> Installing sudo"
if ! command -v sudo >/dev/null 2>&1; then
    apt install -y sudo
else
    echo "            (already installed)"
fi

echo ""
echo "----------> Adding user $USERNAME to sudo group"
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
echo "----------> Done! User $USERNAME can now use sudo without a password."
