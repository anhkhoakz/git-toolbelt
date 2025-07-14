# default recipe
default: help
        @just --list

# help menu
help:
        @echo "usage: just <recipe>"

# install binary
install:
        #!/usr/bin/env bash

        echo "Installing git-toolbelt"
        binary_list=$(fd --type=file 'git-*' --exclude=img)
        sudo install -m 755 $binary_list /usr/local/bin

# uninstall binary
uninstall:
        #!/usr/bin/env bash

        echo "Uninstalling git-toolbelt"
        binary_list=$(fd --type=file 'git-*' --exclude=img)
        for binary in $binary_list; do
                sudo rm -f /usr/local/bin/$binary
        done
