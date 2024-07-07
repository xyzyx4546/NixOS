{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    swww
    zenity
    gradience
    (python3.withPackages (ps: with ps; [ mako jinja2 material-color-utilities pillow ]))
  ];

  home.file.".config/material" = {
    recursive = true;
    source = ./material;
  };
}
