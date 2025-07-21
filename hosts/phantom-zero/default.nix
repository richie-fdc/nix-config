{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  user = "richie";
in
{
  imports = [
    ../../modules/fonts.nix
    ../../modules/homebrew.nix
    ../../modules/nix.nix
    ../../modules/packages.nix
    ../../modules/security.nix
    ../../modules/system-defaults.nix
    ../../tools/dock-configurator.nix
    # ../../tools/spotlight-fix.nix
    # user- and host-specific layers
    ../../home/${user}/home.nix
  ];

  # Host-only facts
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
  system.primaryUser = user;

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}
