{ pkgs, ... }:

{
  imports = [
    ./home/programs/git
    ./home/programs/kitty
    ./home/programs/neofetch

    ./home/system/hyprland
  ];

  home = {
    username = "xyzyx";
    homeDirectory = "/home/xyzyx";

    packages = with pkgs; [
      hello
      neovim
    ];

    file.".config/wallpapers" = {
      recursive = true;
      source = ../../wallpapers;
    };

    file.".config/eww/scripts/material/colors" = {
      recursive = true;
      source = ../../colors;
    };

    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
