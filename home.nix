{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true; # intero only?

  home.packages = [
    pkgs.emacs-all-the-icons-fonts
    pkgs.awscli
    pkgs.bandwhich
    pkgs.breeze-icons
    pkgs.du-dust
    pkgs.fd
    pkgs.gawk # for unrar in mc
    pkgs.gitAndTools.hub
    pkgs.kdiff3
    pkgs.keybase-gui
    pkgs.libreoffice
    pkgs.jetbrains.idea-community
    pkgs.maim
    pkgs.manpages
    pkgs.meld
    pkgs.mc
    pkgs.mpv
    pkgs.multimarkdown
    pkgs.openssh
#    pkgs.ormolu
    pkgs.procs
    pkgs.ripgrep
    pkgs.rustup
    pkgs.simple-scan
    pkgs.stack
    pkgs.strace
    pkgs.tree
# dies on ? entered
    #    pkgs.ytop
    pkgs.unrar
#    pkgs.zoom-us doesn't work even with nixGL
    pkgs.zenith
  ];


  fonts.fontconfig.enable = true;

  home.file.".emacs".source = "${./emacs/init.el}";
  home.sessionVariables = {
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    XDG_DATA_DIRS = "$HOME/.nix-profile/share\${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS";
  };

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: with epkgs; [
      ag
      all-the-icons
      cargo
      dante
      diff-hl
      doom-modeline
      flycheck-pos-tip
      flycheck-rust
      forge
      # fails compiling because of MonadFail
      #      hindent
      lsp-mode
      lsp-ui
      magit
      markdown-mode
      markdown-toc
      material-theme
      nix-mode
      org
      # 20.03 contains melpa snapshot for 2020-01-08 and ormolu package is just too old
      #      ormolu
      #      powerline
      prescient
      projectile
      purescript-mode
      rg
      ripgrep # for use with projectile
      rust-mode
      selectrum
      selectrum-prescient
      terraform-mode
      treemacs
      treemacs-magit
      use-package
      yaml-mode
      ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.gpg.enable =  true;
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
  programs.ssh.enable = true;
  programs.vscode = {
    enable = true;
    extensions = [ pkgs.vscode-extensions.matklad.rust-analyzer ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "3E5F0C40E930755454B23E8920395C100F133AD1" ];
  };

  services.kbfs.enable = true;
  services.keybase.enable = true;
}
