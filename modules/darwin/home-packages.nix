{ pkgs }:

with pkgs;
let shared-packages = import ../shared/home-packages.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
  yabai
  skhd
]
