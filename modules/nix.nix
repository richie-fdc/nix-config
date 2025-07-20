{ ... }:
{
  nix = {
    enable = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
}
