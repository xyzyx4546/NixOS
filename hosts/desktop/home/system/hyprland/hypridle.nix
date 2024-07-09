{ ... }: {

  services.hypridle = {
    enable = true;

    settings = {
      listener = [{
        timeout = 10;
        on-timeout = "hyprlock";
      }]
    };
  };
}