{
  description = "qrilka's Home Manager config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    ai-setup.url = "github:qrilka/ai-setup";
    home-manager = {
      url = "github:nix-community/home-manager/master"; # ai-setup doesn't work with 26.05
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ai-setup,
  }:
    let
      username = "kirill";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit pkgs-unstable;
        };

        modules = [
          ./home.nix
          ai-setup.homeManagerModules.default
          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
              stateVersion = "26.05";
            };
          }
        ];
      };
    };
}
