{ pkgs, ... }: {

  imports = [
    ./hyprlock.nix
    #./hypridle.nix
    #./hyprpaper.nix
    # ./hyprcursor.nix
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
    qt5.qtwayland
    qt6.qtwayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      exec-once = [
        "swww-daemon"
      ];

      monitor = [
        "HDMI-A-1, 1980x1080@60, 0x0, 1"
        "DP-3, 2560x1440@144, 1980x-200, 1"
      ];

      input = {
        kb_layout = "de";
        numlock_by_default = true;
        repeat_rate = 50;
        repeat_delay = 200;
        accel_profile = "flat";
      };

      bind = [
        # Window management
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, escape, exit,"
        "bind = $mainMod, F, togglefloating,"
        ",F11, fullscreen, 0"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"


        # Programms
        "$mainMod, C, exec, kitty"
        #"$mainMod, B, exec, $HOME/.config/hypr/scripts/browser.sh"
        "$mainMod, B, exec, firefox"
        "$mainMod, E, exec, ranger"
        "$mainMod, L, exec, hyprlock"
        "$mainMod SHIFT, Q, exec, $EWW_SCRIPTS/launcher/toggle_launcher.sh powermenu"
        ",PRINT, exec, grimblast --notify --freeze copysave area"

        # Workspaces
        "$mainMod, N, workspace, r+1"
        "$mainMod SHIFT, N, movetoworkspace, r+1"
        "ALT, Tab, workspace, m+1"
        "ALT SHIFT, Tab, workspace, m-1"
        "$mainMod CTRL, right, workspace, m+1"
      ];
      bindm = [
        ", mouse:277, movewindow"
        "$mainMod, mouse:272, resizewindow"
      ];

      env = [
        "XCURSOR_SIZE, 24"
        "HYPRCURSOR_SIZE, 24"

        # FIREFOX
        "MOZ_DISABLE_RDD_SANDBOX, 1"
        "EGL_PLATFORM, wayland"
        "MOZ_ENABLE_WAYLAND, 1"
      ];

      misc = {
        disable_hyprland_logo = true;
	      force_default_wallpaper = 0;
      };
    };
  };
}
