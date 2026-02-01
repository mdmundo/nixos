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
      pkgs = import dev { inherit system; };
    in
    {
      packages.x86_64-linux = {
        default = pkgs.hello;
        deno = pkgs.deno;
      };
      devShells.x86_64-linux = {
        default = pkgs.mkShell { nativeBuildInputs = [ pkgs.hello ]; };
        node = pkgs.mkShell { packages = [ pkgs.nodejs ]; };
        host = pkgs.mkShell { shellHook = "exec code"; };
      };
      nixosConfigurations = {
        hp = nixpkgs.lib.nixosSystem {
          inherit system;
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
      };
    };
}
