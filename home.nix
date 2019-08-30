{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true; # intero only?

  home.packages = [
    pkgs.ag
    pkgs.haskellPackages.hindent
    (pkgs.haskell.lib.dontCheck pkgs.haskellPackages.intero)
    pkgs.gitAndTools.hub
    pkgs.mc
    pkgs.multimarkdown
    pkgs.stack
    pkgs.strace
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: with epkgs; [
      ag
      hindent
      intero
      ivy
      magit
      markdown-mode
      material-theme
      nix-mode
      powerline
      purescript-mode
      rust-mode
      smex
      terraform-mode
      use-package
      yaml-mode
      ];
  };
  home.file.".emacs".source = "${./emacs/init.el}";

  programs.git = {
    enable = true;
    userName = "Kirill Zaborsky";
    userEmail = "qrilka@gmail.com";
    signing = {
      key = "17924AD2";
    };
  };

  home.sessionVariables = {
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };
}
