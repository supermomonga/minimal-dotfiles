# how to use

## Full setup (as root on a fresh server)

Creates a user, configures sudo, and sets up the environment:

```
curl -fsSL https://raw.githubusercontent.com/supermomonga/minimal-dotfiles/master/install.sh | sh -s -- USERNAME
```

If no username is provided, defaults to `main`.

## Personal setup only (as existing user)

```
curl -fsSL https://raw.githubusercontent.com/supermomonga/minimal-dotfiles/master/install.sh | sh
```

## Enable sudoer (as root)

Adds the current user to the sudo group and configures passwordless sudo. Useful when `install.sh` was run directly as a non-root user:

```
curl -fsSL https://raw.githubusercontent.com/supermomonga/minimal-dotfiles/master/enable_sudoer.sh | sudo sh
```
