{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/7109b680d161993918b0a126f38bc39763e5a709";
    updates.url = "github:nixos/nixpkgs/cbe2b770fc8eeca5fb1440f6f4c5a13e63f743b9";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      nixpkgs,
      updates,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        nitro = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            updates = import updates {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = [
            nitro/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.edmundo = import nitro/home/edmundo.nix;
              };
            }
          ];
        };
      };
    };
}
