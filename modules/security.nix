# modules/security.nix
{ ... }:
{
  security.pam.services.sudo_local.touchIdAuth = true;
}
