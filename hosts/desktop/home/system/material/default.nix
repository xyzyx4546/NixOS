{ pkgs, ... }: {

  home.packages = with pkgs; [
    swww
  ];

  home.file.".config/material" = {
    recursive = true;
    source = ../../../packages/material;
  };
}
