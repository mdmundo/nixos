{
  description = "NixOS configuration";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "pkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "pkgs";
      inputs.home-manager.follows = "home-manager";
    };
    dev.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{
      pkgs,
      home-manager,
      plasma-manager,
      dev,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import dev { inherit system; };
      specialArgs = {
        dev = import dev {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      packages.x86_64-linux = {
        default = pkgs.hello;
        deno = pkgs.deno;
      };
      devShells.x86_64-linux = {
        default = pkgs.mkShell {
          buildInputs = [
            pkgs.corepack_23
            pkgs.nodejs_23
          ];
        };
        node_18 = pkgs.mkShell {
          buildInputs = [
            pkgs.corepack_18
            pkgs.nodejs_18
          ];
        };
      };
      nixosConfigurations = {
        mini = pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            mini/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.edmundo = import mini/home.nix;
                sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              };
            }
          ];
        };
        nitro = pkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
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
      };
    };
}
