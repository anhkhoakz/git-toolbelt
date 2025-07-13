# Default recipe
default: help
        @just --list

# Help menu help:
help:
        @echo "usage: just <recipe>"

# Install binary
install:
        #!/usr/bin/env bash
        echo "Installing git-toolbelt"
        binary_list=$(fd --type=file 'git-*' --exclude=img)
        sudo install -m 755 $binary_list /usr/local/bin

# Uninstall binary
uninstall:
        #!/usr/bin/env bash
        echo "Uninstalling git-toolbelt"
        binary_list=$(fd --type=file 'git-*' --exclude=img)
        for binary in $binary_list; do
                sudo rm -f /usr/local/bin/$binary
        done
