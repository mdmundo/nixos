{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/7109b680d161993918b0a126f38bc39763e5a709";
    updates.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      updates,
      home-manager,
      plasma-manager,
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
                users.edmundo = import nitro/home.nix;
                extraSpecialArgs = specialArgs;
                sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              };
            }
          ];
        };
        mini = updates.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [ mini/configuration.nix ];
        };
      };
    };
}
