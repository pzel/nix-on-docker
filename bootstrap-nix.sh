#!/bin/bash
# /nix should be mounted as a persistent volume
cd $HOME
if [ -a /nix/var/nix/profiles/default ];
then 
    echo "Found nix installation, linking"
    ln -s /nix/var/nix/profiles/default $HOME/.nix-profile;
    echo 'https://nixos.org/channels/nixpkgs-unstable nixpkgs' > $HOME/.nix-channels
    mkdir $HOME/.nix-defexprs
    ln -s /nix/var/nix/profiles/per-user/nnn/channels $HOME/.nix-defexprs/channels
    echo "if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi" >> $HOME/.profile
    source $HOME/.nix-profile/etc/profile.d/nix.sh
else 
    echo "Installing nix from scratch";
    curl -O https://nixos.org/nix/install && bash ./install;
    source $HOME/.nix-profile/etc/profile.d/nix.sh
fi
