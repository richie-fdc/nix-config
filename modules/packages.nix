# modules/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-completion
    colima
    coreutils
    docker
    docker-compose
    firefox
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
  ];
}
