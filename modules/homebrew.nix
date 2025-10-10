# modules/homebrew.nix
{ inputs, lib, ... }:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    user = lib.mkDefault "ricardo.silva"; # overridden per-host if needed
    enable = true;
    mutableTaps = false;
    autoMigrate = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core or null;
      "homebrew/homebrew-cask" = inputs.homebrew-cask or null;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle or null;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
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
      "neovim"
      "obsidian"
      "ollama"
      "postman"
      "visual-studio-code"
      "whatsapp"
      "zed"
      # "logi-options+" # Not working
    ];
  };
}
