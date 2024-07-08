{ pkgs, ... }: {

  imports = [
    ./home/programs/git
    ./home/programs/kitty
    ./home/programs/neofetch

    ./home/system/ags
    ./home/system/gtk
    ./home/system/hyprland
    ./home/system/material
  ];

  home = {
    username = "xyzyx";
    homeDirectory = "/home/xyzyx";

    packages = with pkgs; [
      hello
      neovim
      zip

      # Programs
      #minecraft
    ];

    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
