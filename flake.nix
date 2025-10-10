{
  description = "freiheit.com technologies - Richie Mac setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    dotfiles = {
      url = "github:ricardoedgarsilva/dotfiles?ref=feature/neovim_start";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      nix-homebrew,
      home-manager,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      dotfiles,
    }:
    {
      # Each folder in hosts/* becomes one darwinConfiguration
      darwinConfigurations = builtins.mapAttrs (
        hostName: _:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # Override per-host if needed
          modules = [ ./hosts/${hostName} ];
          specialArgs = { inherit inputs; };
        }
      ) (builtins.readDir ./hosts);
    };
}
