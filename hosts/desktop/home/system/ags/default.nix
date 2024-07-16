{ inputs, pkgs, ... }: {

  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = [pkgs.sassc];

  programs.ags = {
    enable = true;
    #configDir = ./ags;
    extraPackages = with pkgs; [
      #gtksourceview
      #webkitgtk
      #accountsservice
    ];
  };
}