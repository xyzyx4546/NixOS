{ pkgs, ... }: {

  gtk = {
    #enable = true;

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };

  home.file = {
    ".config/gtk-3.0/gtk.css".text = ''
      @import url("file://~/.config/material/colors/colors-gtk.css");
    '';

    ".config/gtk-4.0/gtk.css".text = ''
      @import url("file://~/.config/material/colors/colors-gtk.css");
    '';
  };
}