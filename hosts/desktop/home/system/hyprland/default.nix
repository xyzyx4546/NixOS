{ pkgs, ... }: {
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
    grimblast
    playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      source = "~/.config/material/colors/colors-hyprland.conf";

      exec-once = [
        "swww-daemon"
        "ags"
        
        "sleep 1 && webcord -m"
      ];

      monitor = [
        "HDMI-A-1, 1920x1080@60, 0x0, 1"
        "DP-3, 2560x1440@144, 1920x-200, 1"
      ];

      input = {
        kb_layout = "de";
        numlock_by_default = true;
        repeat_rate = 50;
        repeat_delay = 200;
        accel_profile = "flat";
      };

      general = {
        gaps_in = 5;
        gaps_out = "0, 15, 15, 15";
        "col.active_border" = "$primary";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        resize_on_border = true;
      };

      decoration = {
        rounding = 15;
        blur = {
          enabled = true;
          xray = true;
          size = 1;
          passes = 4;
          new_optimizations = true;
        };
        drop_shadow = "yes";
        shadow_range = 20;
        shadow_render_power = 4;
        "col.shadow" = "$shadow";
        dim_around = "0.5";
      };

      animations = {
        enabled = "yes";

        bezier = "bezier, 0.25, 1, 0.5, 1";

        animation = [ 
          "windows, 1, 6, bezier, popin"
          "border, 1, 6, bezier"
          "borderangle, 1, 6, bezier"
          "fade, 1, 6, bezier"
          "workspaces, 1, 6, bezier"
          "layers, 1, 3, bezier, popin"
        ];
      };

      dwindle = {
        force_split = 0;
        preserve_split = true;
      };

      windowrulev2 = [
        "suppressevent maximize, class:.*"

        "float, class:(floating|zenity)"
        "size 35% 35%, class:(floating|zenity)"
        "dimaround, class:(floating|zenity)"

        "monitor 0, class:(?!.*(WebCord|Spotify|org.telegram.desktop|steam))"
        "workspace 99, class:(WebCord|Spotify|org.telegram.desktop|steam)"
      ];

      layerrule = [
        "noanim, ^(hyprpicker|notification_popup)$"
        "blur, ^(bar)$"
        "ignorealpha 0.7, ^(bar)$"
      ];

      workspace = [
        "1, monitor:DP-3, default:true"
        "2, monitor:DP-3"
        "3, monitor:DP-3"
        "4, monitor:DP-3"
        "5, monitor:DP-3"
        "6, monitor:DP-3"
        "7, monitor:DP-3"
        "8, monitor:DP-3"
        "9, monitor:DP-3"
        "10, monitor:DP-3"
        "98, monitor:HDMI-A-1, gapsout:10, on-created-empty:firefox"
        "99, monitor:HDMI-A-1, gapsout:10, default:true"
      ];

      bind = [
        # Window management
        "SUPER, Q, killactive,"
        "SUPER SHIFT, escape, exit,"
        "bind = SUPER, F, togglefloating,"
        ",F11, fullscreen, 0"

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"


        # Programms
        "SUPER, SUPER_L, exec, ags -t applauncher"
        "SUPER, C, exec, kitty"
        #"SUPER, B, exec, $HOME/.config/hypr/scripts/browser.sh"
        "SUPER, B, exec, firefox"
        "SUPER, L, exec, hyprlock"
        "SUPER SHIFT, Q, exec, $EWW_SCRIPTS/launcher/toggle_launcher.sh powermenu"
        ",PRINT, exec, grimblast --notify --freeze copysave area"
        "SUPER, W, exec, python ~/.config/material/material.py random"
        "SUPER SHIFT, W, exec, python ~/.config/material/material.py select"

        # Workspaces
        "SUPER, N, workspace, r+1"
        "SUPER SHIFT, N, movetoworkspace, r+1"
        "ALT, Tab, workspace, m+1"
        "ALT SHIFT, Tab, workspace, m-1"
        "SUPER, Tab, focusmonitor, +1"
        "SUPER SHIFT, Tab, focusmonitor, -1"
      ];
      bindm = [
        ", mouse:277, movewindow"
        "SUPER, mouse:272, resizewindow"
      ];
      bindl = [
        ", XF86AudioMute, exec, ags -r \"const { open } = await import('file://$HOME/.config/ags/widgets/volume_OSD.js'); open();\" & wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioRaiseVolume, exec, ags -r \"const { open } = await import('file://$HOME/.config/ags/widgets/volume_OSD.js'); open();\" & wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0"
        ", XF86AudioLowerVolume, exec, ags -r \"const { open } = await import('file://$HOME/.config/ags/widgets/volume_OSD.js'); open();\" & wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05- -l 0.0"
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
