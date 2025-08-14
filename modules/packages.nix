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
    gettext
    gh
    git
    google-cloud-sdk
    gpg
    hermitcli
    lcov
    neofetch
    nixfmt
    nodejs
    obsidian
    sops
    thunderbird
    vscode
  ];
}
