{ lib, pkgs, ... }: {

  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    gtk3.extraCss = ''
      @import url("../material/colors/colors-gtk.css");
    '';

    gtk4.extraCss = ''
      @import url("../material/colors/colors-gtk.css");
    '';
  };
}