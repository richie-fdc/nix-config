# modules/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-completion
    coreutils
    docker
    docker-compose
    flock
    gettext
    gh
    git
    gnupg
    google-cloud-sdk
    hermitcli
    lcov
    neofetch
    neovim
    nixfmt
    nodejs
    sops
    sqlfluff
  ];
}
