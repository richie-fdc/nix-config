{
  description = "freiheit.com technologies - richie";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = { url = "github:zhaofengli-wip/nix-homebrew"; };
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
      url = "github:ricardoedgarsilva/dotfiles";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, homebrew-bundle
    , homebrew-core, homebrew-cask, home-manager, nixpkgs, dotfiles, ... }:
    let
      user = "ricardo.silva";
      darwinSystems = [ "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs (darwinSystems) f;

      # Define an development shell for unix systems.
      # This is useful when using `nix develop` to enter a shell with the specified environment.
      devShell = system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = with pkgs;
            mkShell {
              nativeBuildInputs = with pkgs; [ bashInteractive git ];
              shellHook = with pkgs; ''
                export EDITOR=vim
              '';
            };
        };

    in {
      devShells = forAllSystems devShell;

      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system:
        let user = "ricardo.silva";
        in nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./hosts/darwin
          ];
        });
    };
}
