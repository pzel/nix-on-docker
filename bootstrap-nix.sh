#!/bin/bash
# /nix should be mounted as a persistent volume
cd $HOME
if [ -a /nix/var/nix/profiles/default ] && ! [ -a "$HOME/.nix-profile" ];
then 
    echo "Found /nix installation, relinking"
    ln -s /nix/var/nix/profiles/default $HOME/.nix-profile;
    echo 'https://nixos.org/channels/nixpkgs-unstable nixpkgs' > $HOME/.nix-channels
    mkdir $HOME/.nix-defexprs
    ln -s /nix/var/nix/profiles/per-user/nnn/channels $HOME/.nix-defexprs/channels
    echo "if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi" >> $HOME/.profile
    echo -e '\nInstallation finished!  To ensure that the necessary environment\n
variables are set, either log in again, or type\n

  . /home/nnn/.nix-profile/etc/profile.d/nix.sh'
elif [ -a "$HOME/.nix-profile" ]
then 
    echo "All set, nothing to do";
else     
    echo "Installing nix from scratch";
    curl -O https://nixos.org/nix/install && bash ./install;
fi
