{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.ag
    pkgs.mc
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
      nix-mode
      powerline
      railscasts-reloaded-theme
      smex
      use-package
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
