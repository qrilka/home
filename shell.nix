let

  sources = import ./nix/sources.nix;

  nixpkgs = sources."nixos-20.09";

  pkgs = import nixpkgs {};

in pkgs.mkShell rec {

  name = "home-manager-shell";

  buildInputs = with pkgs; [
    niv
    (import sources.home-manager {inherit pkgs;}).home-manager
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${sources."home-manager"}"
    export HOME_MANAGER_CONFIG="./home.nix"
    export TERMINFO_DIRS="/usr/lib/terminfo"
  '';
}
