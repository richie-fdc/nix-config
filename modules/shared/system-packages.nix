{ pkgs }:

with pkgs; [
  # Utilities/Tools
  pkgs.bash-completion
  pkgs.coreutils
  pkgs.neofetch
  pkgs.lcov
  pkgs.nixfmt
  pkgs.gh

  # Productivity & Office
  pkgs.obsidian
  pkgs.thunderbird


  # Development & Tools
  pkgs.google-cloud-sdk
  pkgs.colima
  pkgs.docker
  pkgs.docker-compose
  pkgs.git
  pkgs.hermitcli
  pkgs.vscode
  pkgs.nodejs

  # Browsers
  pkgs.firefox
]
