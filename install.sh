#!/bin/bash
# The MIT License (MIT)
# Copyright © 2017 Shreyas Minocha <shreyas@shreyasminocha.me>

# Full license text available at https://shreyas.mit-license.org

# Install script for polka-dot
echo "This install script requires cURL installed on the system.\n"
echo "If this script fails due to absence of cURL on your system, try again after installing cURL.\n"
echo "Assuming that $PWD is your dotfile directory.\n"
curl -o /usr/bin/ https://raw.githubusercontent.com/shreyasminocha/polka-dot/master/polka.sh
curl -O https://raw.githubusercontent.com/shreyasminocha/polka-dot/master/.polkaignore_default
mv /usr/bin/polka.sh /usr/bin/polka
mv .polkaignore_default .polkaignore
echo "Installed polka to /usr/bin.\n"
echo "Created a default polkaignore file in $PWD.\n"
echo "Run `polka link` in current directory to link your dotfiles to the home directory.\n"
