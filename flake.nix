{
  description = "NixOS configuration";

  inputs = {
    nitro.url = "github:nixos/nixpkgs/7109b680d161993918b0a126f38bc39763e5a709";
    nitro-hm = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nitro";
    };
    nitro-pm = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nitro";
      inputs.home-manager.follows = "nitro-hm";
    };

    mini.url = "github:nixos/nixpkgs/b47fd6fa00c6afca88b8ee46cfdb00e104f50bca";
    mini-hm = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "mini";
    };
    mini-pm = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "mini";
      inputs.home-manager.follows = "mini-hm";
    };
  };

  outputs =
    inputs@{
      nitro,
      nitro-hm,
      nitro-pm,
      mini,
      mini-hm,
      mini-pm,
      ...
    }:
    {
      nixosConfigurations = {
        nitro = nitro.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            mini = import mini {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = [
            nitro/configuration.nix
            nitro-hm.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.edmundo = import nitro/home.nix;
                extraSpecialArgs = specialArgs;
                sharedModules = [ nitro-pm.homeManagerModules.plasma-manager ];
              };
            }
          ];
        };
        mini = mini.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            mini/configuration.nix
            mini-hm.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.edmundo = import mini/home.nix;
                sharedModules = [ mini-pm.homeManagerModules.plasma-manager ];
              };
            }
          ];
        };
      };
    };
}
