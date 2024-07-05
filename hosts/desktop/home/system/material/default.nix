{ pkgs, ... }: {

  home.packages = with pkgs; [
    swww
    python312
    python312Packages.jinja2
    python312Packages.Pillow
    python312Packages.material-color-utilities
  ];

  home.file.".config/material" = {
    recursive = true;
    source = ../../../packages/material;
  }
}
