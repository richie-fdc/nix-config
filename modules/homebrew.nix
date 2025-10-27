# modules/homebrew.nix
{ inputs, lib, ... }:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    user = lib.mkDefault "ricardo.silva"; # overridden per-host if needed
    enable = true;
    mutableTaps = true;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    brews = [
      "fastlane"
    ];

    casks = [
      "1password"
      "chatgpt"
      "firefox"
      "godot"
      "microsoft-teams"
      "obsidian"
      "ollama-app"
      "postman"
      "visual-studio-code"
      "whatsapp"
      "zed"
      # "logi-options+" # Not working
    ];
  };
}
