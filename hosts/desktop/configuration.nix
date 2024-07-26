{ pkgs, ... }: {

  imports = [ ./hardware-configuration.nix ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 28d";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de-latin1";

  users.users.xyzyx = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "xyzyx";
  };

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
      NIXOS_OZONE_WL = "1";
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      home-manager
      tree ranger vscode webcord spotify #temp
    ];
  };

  fonts = {
    packages = with pkgs; [
      font-awesome
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      (pkgs.callPackage ./packages/nunito/nunito.nix { inherit pkgs; })
    ];
  };

  programs.hyprland.enable = true;

  system.stateVersion = "24.05";
}

