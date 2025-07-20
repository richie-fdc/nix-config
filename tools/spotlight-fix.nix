# modules/spotlight-fix.nix
{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.file."Applications/Home Manager".source =
    let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "Applications";
      };
    in
    "${apps}/Applications";
}
