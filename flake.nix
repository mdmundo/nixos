{
  description = "NixOS configuration";

  inputs = {
    nitro.url = "github:nixos/nixpkgs/nixos-24.05";
    nitro-hm = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nitro";
    };
    nitro-pm = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nitro";
      inputs.home-manager.follows = "nitro-hm";
    };
    mini.url = "github:nixos/nixpkgs/nixos-24.11";
    mini-hm = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "mini";
    };
    mini-pm = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "mini";
      inputs.home-manager.follows = "mini-hm";
    };
    dev.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{
      nitro,
      nitro-hm,
      nitro-pm,
      mini,
      mini-hm,
      mini-pm,
      dev,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import dev { inherit system; };
      specialArgs = {
        updates = import mini {
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
        mini = mini.lib.nixosSystem {
          inherit system;
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
        nitro = nitro.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
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
      };
    };
}
