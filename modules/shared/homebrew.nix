{ config, pkgs, ... }:

{
  # Shared homebrew configuration across all hosts
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    
    # Shared homebrew packages
    brews = [
    ];
    
    # Shared homebrew casks
    casks = [
      "1password"
      "chatgpt"
      "deepl"
      "logi-options+"
      "microsoft-teams"
      "postman"
      "whatsapp"
    ];
    
    masApps = {
    };
  };
}
