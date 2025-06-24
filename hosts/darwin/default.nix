{config, pkgs, ...}:

let user = "ricardo.silva"; in

{
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
  ];

  nix = {
    # Since the determinate flavour is installed, this disables the nix version management from nix-darwin.
    enable = false;
  };

  system = {
    # Used for backwards compatibility
    stateVersion = 6;
    primaryUser = user;

    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
      };

      dock = {
          autohide = true;
          show-recents = false;
          launchanim = true;
          orientation = "bottom";
          tilesize = 48;
      };
    };
  };

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
    # Set up applications.
    echo "setting up /Applications..." >&2
    rm -rf /Applications/Nix\ Apps
    mkdir -p /Applications/Nix\ Apps
    find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
    while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
    done
        '';

  security = {
    pam.services.sudo_local.touchIdAuth = true;
  };



}