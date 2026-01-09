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
    dev.url = "github:nixos/nixpkgs/nixos-unstable";
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
      pkgs = import dev {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.x86_64-linux = {
        default = pkgs.hello;
        deno = pkgs.deno;
      };
      devShells.x86_64-linux = {
        default = pkgs.mkShell {
          packages = [ pkgs.vscode ];
          shellHook = "exec code";
        };
        hello = pkgs.mkShell { nativeBuildInputs = [ pkgs.hello ]; };
      };
      nixosConfigurations = {
        mini = nixpkgs.lib.nixosSystem {
          inherit system;
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
