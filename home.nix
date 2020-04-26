{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true; # intero only?

  home.packages = [
    pkgs.ag
    pkgs.breeze-icons
    pkgs.gitAndTools.hub
    pkgs.kdiff3
    pkgs.mc
    pkgs.multimarkdown
    pkgs.ormolu
    pkgs.stack
    pkgs.strace
    pkgs.tree
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: with epkgs; [
      ag
      dante
      forge
      hindent
      ivy
      magit
      markdown-mode
      markdown-toc
      material-theme
      nix-mode
      org
      ormolu
      powerline
      purescript-mode
      rust-mode
      smex
      terraform-mode
      treemacs
      treemacs-magit
      use-package
      yaml-mode
      ];
  };
  home.file.".emacs".source = "${./emacs/init.el}";

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Kirill Zaborsky";
    userEmail = "qrilka@gmail.com";
    signing = {
      key = "17924AD2";
      signByDefault = true;
    };
    extraConfig = {
      github = {
        user = "qrilka";
      };
      credential = {
        helper = "store --file ~/.git.credentials";
      };
      merge.tool = "kdiff3";
    };
  };

  programs.gpg.enable = true;

  home.sessionVariables = {
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    XDG_DATA_DIRS = "$HOME/.nix-profile/share\${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS";
  };
}
