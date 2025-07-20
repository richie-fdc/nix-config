{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    ibm-plex
    jetbrains-mono
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.zed-mono
  ];
}
