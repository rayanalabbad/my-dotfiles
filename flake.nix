{
  description = "Example nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    nur.url = "github:nix-community/NUR";
    nixvim.url = "github:nix-community/nixvim";
  };
  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      nur,
      nixvim,
    }:
    let
      username = "rayanalabbad";
    in
    {
      darwinConfigurations."Rayans-MacBook-Air" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs self username homebrew-core homebrew-cask nur;
          system = "aarch64-darwin";
        };
        modules = [
          ./modules/common.nix
          ./hosts/darwin/default.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.overwriteBackup = true;
            home-manager.extraSpecialArgs = {
              inherit inputs username;
              isDarwin = true;
              system = "aarch64-darwin";
            };
            home-manager.users.${username} = import ./modules/home.nix;
          }
        ];
      };
    };
}
