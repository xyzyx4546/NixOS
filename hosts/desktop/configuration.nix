{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 28d";
    };
  };
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [  ];
  networking.firewall.allowedUDPPorts = [  ];

  time.timeZone = "Europe/Berlin";

  users.users.xyzyx = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bashInteractive;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de-latin1";

  services = {
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "xyzyx";
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --remember --remember-user-session --time --cmd ${pkgs.hyprland}/bin/Hyprland";
          user = "greeter";
        };
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };

  environment = {
    variables = {
      MOZ_ENABLE_WAYLAND = "1";
      ANKI_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      home-manager
      firefox
      tree
      ranger
      vscode
    ];
  };

  programs.hyprland.enable = true;

  system.stateVersion = "24.05";
}

