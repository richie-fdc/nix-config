{ pkgs }:

with pkgs;
let shared-packages = import ../shared/system-packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # ...
]
