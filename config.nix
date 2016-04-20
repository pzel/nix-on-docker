{
  packageOverrides = pkgs_: with pkgs_; {
    all = with pkgs; buildEnv { 
      name = "all";
      paths = [
        git
        emacs24-nox
        ghc
        cabal-install
        haskellPackages.unix
        htop
        lua
      ];
    };
  };
}
