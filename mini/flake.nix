{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    {
      nixosConfigurations = {
        nitro = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [ ./configuration.nix ];
        };
      };
    };
}
