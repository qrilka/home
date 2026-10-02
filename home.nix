{ config, pkgs, pkgs-unstable, ... }:

{
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      keep-derivations = true;
      keep-outputs = true;
    };
  };

  nixpkgs.config = import ./nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  home.packages = [
    pkgs.adwaita-icon-theme
    pkgs.awscli
    pkgs.bandwhich
    pkgs.bat
    pkgs.bitwarden-cli
    pkgs.dbeaver-bin
    pkgs.devenv
    pkgs.dua
    pkgs.dust
    pkgs.emacs-all-the-icons-fonts
    pkgs.evince
    pkgs.fd
    pkgs.gawk # for unrar in mc
    pkgs.gh
    pkgs.gimp
    pkgs.hub
    pkgs.gnome-themes-extra
    pkgs.go
    pkgs.graphviz
    pkgs.hicolor-icon-theme
    pkgs.jjui
    pkgs.just
    pkgs.kdiff3
    pkgs.keybase-gui
    pkgs.libreoffice
    pkgs.logseq
    pkgs.maim
    pkgs.man-pages
    pkgs.meld
    pkgs.mc
    pkgs.mise
    (config.lib.nixGL.wrap pkgs.mpv)
    pkgs.multimarkdown
    pkgs.nerd-fonts.symbols-only # for nerd-icons.el
    pkgs.nix-tree
    pkgs.nixfmt
    pkgs.nodejs
    pkgs.typescript
    # use gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11' to set gnome font
    # and also gsettings set org.gnome.desktop.interface monospace-font-name 'Noto Sans Mono 11'
    pkgs.noto-fonts
    pkgs.openssh
    pkgs.procs
    pkgs.ranger
    pkgs.ripgrep
    pkgs.simple-scan
    pkgs.smartmontools
    pkgs.stack
    pkgs.strace
    pkgs.stylish-haskell
    pkgs.tree
    pkgs.typst
    pkgs.unrar
    pkgs.yt-dlp
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
      catppuccin-theme
      csv-mode
      dante
      diff-hl
      direnv
      doom-modeline
      editorconfig
      flycheck
      flycheck-pos-tip
      flycheck-rust
      forge
      graphql-mode
      haskell-mode
      graphviz-dot-mode
      just-mode
      lsp-mode
      lsp-ui
      lua-mode
      magit
      (pkgs-unstable.emacsPackagesFor pkgs.emacs).majutsu
      markdown-mode
      markdown-toc
      nerd-icons
      neotree
      nix-mode
      org
      org-roam
      prescient
      projectile
      purescript-mode
      ranger
      revert-buffer-all
      rg
      ripgrep # for use with projectile
      rust-mode
      selectrum
      selectrum-prescient
      sqlite3
      terraform-mode
      typescript-mode
      use-package
      xterm-color
      yaml-mode
      yasnippet
      ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.gpg.enable =  true;
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "Kirill Zaborsky";
        email = "qrilka@gmail.com";
      };
      github = {
        user = "qrilka";
      };
      merge = {
        tool = "kdiff3";
        conflictstyle = "diff3";
      };
      pull.ff = "only";
      rerere.enabled = true;
      credential."https://github.com".helper = "!gh auth git-credential";
    };
    signing = {
      key = "17924AD2";
      signByDefault = true;
    };
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Kirill Zaborsky";
        email = "qrilka@gmail.com";
      };
    };
  };
  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;
    settings = {
      "*" = {
        serverAliveInterval = 60;
      };
      "bitbucket-fpco" = {
        hostname = "bitbucket.org";
        identityFile = "~/.ssh/id_rsa_bitbucket";
        identitiesOnly = true;
      };
#      # doesn't work for some reason
#      "*+*" = {
#        proxyCommand = "ssh -v $(echo %h | sed 's/^.*+//;s/^\([^:]*$\)/\1:22/') -W $(echo %h | sed 's/+[^+]*$//;s/\([^+%%]*\)%%\([^+]*\)$/\2 -l \1/;s/:\([^:+]*\)$/ -p \1/')";
#        user = "kzaborsky";
#        identityFile = "~/.ssh/id_ed25519";
#      };
    };
  };

  services.gpg-agent = {
    enable = true;
    enableScDaemon = false;
    enableSshSupport = true;
    sshKeys = [
      "3E5F0C40E930755454B23E8920395C100F133AD1" # RSA
      "DF68CBC2EC32CA05C4D5073BF3FD17291344F658" # Ed25519
    ];
    pinentry = {
      package = pkgs.pinentry-all;
    };
  };

  services.kbfs.enable = true;
  services.keybase.enable = true;

  # no socket in session variables at least since 26.05
  systemd.user.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
  };

  xdg.enable = true;
}
