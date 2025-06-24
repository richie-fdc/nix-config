{ pkgs }:

with pkgs; [
  # System packages that can be shared across hosts
  # Add system-level packages here
  bash-completion
  colima
  coreutils
  docker
  docker-compose
  firefox
  gettext
  gh
  git
  google-cloud-sdk
  hermitcli
  lcov
  neofetch
  nixfmt
  nodejs
  obsidian
  thunderbird
  vscode
]
