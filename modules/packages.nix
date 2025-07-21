# modules/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-completion
    colima
    coreutils
    docker
    docker-compose
    firebase-tools
    firefox
    gettext
    gh
    git
    google-cloud-sdk
    hermitcli
    lcov
    neofetch
    neovim
    nixfmt
    nodejs
    nodejs
    obsidian
    thunderbird
    vscode
  ];
}
