{ pkgs, ... }: {
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
      format = ''
        ╭─$directory$username@$hostname$git_branch$cmd_duration
        ╰─$character
      '';

      character = {
        success_symbol = "[](bold bright-green)";
        error_symbol = "[](bold red)";
      };

      directory = {
        format = "[ $path](bold blue)";
        truncation_symbol = "…/";
      };
      username = {
        format = "  [ $user](bold yellow)";
        show_always = true;
      };
      hostname = {
        format = "[$hostname](bold yellow)";
        ssh_only = false;
      };
      git_branch = {
        format = "  [ $branch](bold #F1502F)";
      };
      cmd_duration = {
        format = "  [󰄉 $duration](bold #808080)";
      };

      scan_timeout = 10;
    };
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      c = "clear";
    };

    #autosuggestion.enable = true;
    #syntaxHighlighting.enable = true;
    #historySubstringSearch.enable = true;
  };
}
