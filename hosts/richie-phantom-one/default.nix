{ config, pkgs, user, hostname, ... }:

{
  imports = [
    ./home-manager.nix
    ../../modules/darwin/dock
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
        KeyRepeat = 6; # Faster key repeat for richie
        InitialKeyRepeat = 25; # Different initial key repeat
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.scaling" = 2.0;
        AppleShowAllExtensions = false;  # Different preference
      };

      dock = {
        autohide = true;
        show-recents = true;
        launchanim = false;
        orientation = "bottom"; 
        tilesize = 42; 
        
        # Host-specific dock configuration
        minimize-to-application = false;
        show-process-indicators = false;
      };
      
      finder = {
        AppleShowAllExtensions = false;
        FXPreferredViewStyle = "icnv";  # Icon view
        ShowPathbar = false;
        ShowStatusBar = false;
      };
      
      # Host-specific keyboard shortcuts
      CustomUserPreferences = {
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Different Mission Control shortcuts for richie
            "32" = { enabled = true; value = { parameters = [ 65535 50 1048576 ]; type = "standard"; }; };
            "33" = { enabled = true; value = { parameters = [ 65535 50 1572864 ]; type = "standard"; }; };
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
    neovim  # Different editor preference
    git
    curl
    htop
    # Add more host-specific packages for richie
  ];
}
