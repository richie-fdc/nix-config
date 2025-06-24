{ config, pkgs, user, hostname, ... }:

{
  imports = [
    ../../modules/darwin/home-manager.nix
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
        
        # Host-specific global defaults for ricardo.silva
        "com.apple.trackpad.scaling" = 3.0;
        AppleShowAllExtensions = true;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 56;  # Larger dock for ricardo.silva
        
        # Host-specific dock configuration
        minimize-to-application = true;
        show-process-indicators = true;
      };
      
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";  # Column view
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      
      # Host-specific keyboard shortcuts
      CustomUserPreferences = {
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Mission Control shortcuts for ricardo.silva
            "32" = { enabled = true; value = { parameters = [ 65535 49 1048576 ]; type = "standard"; }; };
            "33" = { enabled = true; value = { parameters = [ 65535 49 1572864 ]; type = "standard"; }; };
          };
        };
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

  # Host-specific environment packages
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    # Add more host-specific packages for ricardo.silva
  ];
}
