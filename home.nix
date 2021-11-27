{ config, pkgs, ... }:

let
   bwbackup = pkgs.rustPlatform.buildRustPackage rec {
     pname = "bwbackup";
     version = "0.1.0";

     src = pkgs.fetchFromGitHub {
       owner = "snoyberg";
       repo = pname;
       rev = "9b608ea1cf50f75b10f638ad0a49ee35878fe96c"; # version;
       sha256 = "10rwh61m7881xdqcnvvyxacs5x4g4x55x2z21s168b4wip18dk6g";#"73cb3858a687a8494ca3323053016282f3dad39d42cf62ca4e79dda2aac7d9ac";
     };

     cargoSha256 = "0f92wv0gb1pa7icarqkjj8wyicd4bjw1s6rwsxb59dsnhccnd50n";
   };
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true; # intero only?

  home.packages = [
#    bwbackup
    pkgs.awscli
    pkgs.bandwhich
    pkgs.bitwarden-cli
    pkgs.breeze-icons
    pkgs.dbeaver
    pkgs.du-dust
    pkgs.emacs-all-the-icons-fonts
    pkgs.evince
    pkgs.fd
    pkgs.gawk # for unrar in mc
    pkgs.gimp
    pkgs.gitAndTools.hub
    pkgs.gnome-themes-standard
    pkgs.gnome3.adwaita-icon-theme
    pkgs.gnome-themes-extra
    pkgs.go
    pkgs.hicolor-icon-theme
    pkgs.kdiff3
    pkgs.keybase-gui
    pkgs.libreoffice
    pkgs.jetbrains.idea-community
    pkgs.just
    pkgs.maim
    pkgs.manpages
    pkgs.meld
    pkgs.mc
    pkgs.mpv
    pkgs.multimarkdown
    pkgs.nix-tree
    pkgs.nixfmt
    pkgs.nodePackages.typescript
    pkgs.openssh
#    pkgs.ormolu
    pkgs.plantuml
    pkgs.procs
    pkgs.ripgrep
    pkgs.rustup
    pkgs.simple-scan
    pkgs.stack
    pkgs.strace
    pkgs.stylish-haskell
    pkgs.teams
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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: with epkgs; [
      ag
      all-the-icons
      cargo
      dante
      diff-hl
      direnv
      doom-modeline
      flycheck-pos-tip
      flycheck-rust
      forge
      graphql-mode
      # fails compiling because of MonadFail
      #      hindent
      just-mode
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
      typescript-mode
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
      merge = {
        tool = "kdiff3";
        conflictstyle = "diff3";
      };
      pull.ff = "only";
      rerere.enabled = true;
    };
  };
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "bitbucket-fpco" = {
        hostname = "bitbucket.org";
        identityFile = "~/.ssh/id_rsa_bitbucket";
        identitiesOnly = true;
      };
    };
  };
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.matklad.rust-analyzer
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # pkgs.vscode-extensions.golang.Go
      {
        name = "Go";
        publisher = "golang";
        version = "0.18.1";
        sha256 = "sha256-b2Wa3TULQQnBm1/xnDCB9SZjE+Wxz5wBttjDEtf8qlE=";
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "3E5F0C40E930755454B23E8920395C100F133AD1" ];
  };

  services.kbfs.enable = true;
  services.keybase.enable = true;

  xdg.enable = true;
}
