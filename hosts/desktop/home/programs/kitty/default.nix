{ config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    settings = {
      include = "~/.config/eww/scripts/material/colors/colors-kitty.conf";
      font_size = 12;
      font_family = "Sono Monospace";
      window_margin_width = 11;
      remember_window_size = "no";
      background_opacity = "0.7";

      confirm_os_window_close = 0;
    };
  };
}