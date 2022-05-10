#let
#
#  sources = import ./nix/sources.nix;
#
#  nixpkgs = sources."nixos-21.05";
#
#  pkgs = import nixpkgs {};
#
#in pkgs.mkShell rec {
#
#  name = "home-manager-shell";
#
#  buildInputs = with pkgs; [
#    niv
#    (import sources.home-manager {inherit pkgs;}).home-manager
#  ];
#
#  shellHook = ''
#    export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${sources."home-manager"}"
#    export HOME_MANAGER_CONFIG="./home.nix"
#    export TERMINFO_DIRS="/usr/lib/terminfo"
#  '';
#}
#
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/7d673c71c1a838dc8e2b51e3e48e719f6629fc67.tar.gz") {} }:
pkgs.mkShell {
  buildInputs = [
#    ibmcli
#    pkgs.kubectl
#    pkgs_unstable.kustomize
#    pkgs.python3
#    pkgs.pipenv
#    pkgs.docker-compose
#    pkgs.argocd
#    pkgs.postgresql
#    pkgs.jq
#    pkgs.yarn
#    pkgs.nodejs
#    pkgs_unstable.terraform_0_14
#    pkgs.minikube
#    pkgs.phpPackages.composer
#    pkgs.vault
#    pkgs.apacheHttpd
    #    pkgs.go-pup
    pkgs.nix
  ];
}
