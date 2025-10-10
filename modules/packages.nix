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
    flock
    gettext
    gh
    git
    gnupg
    google-cloud-sdk
    hermitcli
    lcov
    neofetch
    nixfmt
    nodejs
    sops
    sqlfluff
  ];
}
