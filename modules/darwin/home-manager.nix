{ config, pkgs, lib, home-manager, dotfiles, ... }:
let
  user = "ricardo.silva";
in 
{
  imports = [
    ./dock
  ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";  # Uninstall packages not managed by Homebrew
    };
    casks = pkgs.callPackage ./casks.nix {};

    # Currently not possible to install apps from the Mac App Store
    # masApps = {
    #   "1password" = 1333542190;
    # };
  };

  environment.systemPackages = import ./system-packages.nix { pkgs = pkgs; };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./home-packages.nix {};
        stateVersion = "25.05";
      };

      xdg.enable = true;

      # yabai config
      xdg.configFile."yabai/yabairc" = {
        source = "${dotfiles}/yabai/yabairc";
        executable = true;
      };

      # skhd config
      xdg.configFile."skhd/skhdrc" = {
        source = "${dotfiles}/skhd/skhdrc";
        executable = true;
      };
      
      programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };
    };
  };


  local.dock = {
    enable = true;
    username = user;
    entries = [
      { path = "/Applications/Launchpad.app"; }
      { path = "/Applications/1Password.app"; }
      { path = "/Applications/Google Chrome.app"; }
      { path = "${pkgs.firefox}/Applications/Firefox.app"; }
      { path = "${config.users.users.${user}.home}/Applications/Chrome Apps.localized/Google Chat.app"; }
      { path = "/Applications/Microsoft Teams.app"; }
      { path = "/Applications/WhatsApp.app"; }
      { path = "/Applications/ChatGPT.app"; }
      { path = "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"; }
      { path = "${pkgs.vscode}/Applications/Visual Studio Code.app"; }
      { path = "/Applications/Utilities/Terminal.app"; }
      { path = "/Applications/Postman.app"; }
      { path = "${pkgs.obsidian}/Applications/Obsidian.app"; }
      {
        path = "${config.users.users.${user}.home}/Google Drive/My Drive";
        section = "others";
        options = "--sort name --view grid --display stack";
      }
      {
        path = "${config.users.users.${user}.home}/Downloads";
        section = "others";
        options = "--sort name --view grid --display stack";
      }
    ];
  };


  services.yabai.enable = true ;

  services.skhd.enable = true;



}