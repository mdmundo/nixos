{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      home-manager,
      plasma-manager,
      ...
    }:
    {
      nixosConfigurations = {
        hp = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            hp/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.edmundo = import hp/home.nix;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              };
            }
          ];
        };
        mini = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            mini/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.edmundo = import mini/home.nix;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              };
            }
          ];
        };
      };
    };
}
