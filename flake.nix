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
    dev.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs =
    inputs@{
      nixpkgs,
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
        # nix shell .#deno
        deno = pkgs.deno;
        ghostty = pkgs.ghostty;
      };
      devShells.x86_64-linux = {
        default = pkgs.mkShell {
          packages = [
            pkgs.corepack_24
            pkgs.nodejs_24
          ];
        };
        node18 = pkgs.mkShell {
          # nix develop .#node
          packages = [
            pkgs.corepack_18
            pkgs.nodejs_18
          ];
        };
      };
      nixosConfigurations = {
        mini = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
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
        nitro = nixpkgs.lib.nixosSystem {
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
