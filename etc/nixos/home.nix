{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rayanalabbad";
  home.homeDirectory = "/home/rayanalabbad";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rayanalabbad/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
      EDITOR = "nvim";
      TERM = "xterm-256color";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
    '';
  };
  
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Hack Nerd Font Mono";
      font-size = "12";
      theme = "tokyonight";
      window-decoration = false;
      window-padding-y = "5";
      window-padding-x = "5";
    };
  };
  
  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
      };
    };
    languages = {
      language-server.clangd = {
        command = "clangd";
        args = [ "-header-insertion=never" ];
      }; 
    };
  };

  programs.git = {
    enable = true;
    userName  = "Rayan Alabbad";
    userEmail = "rayan@rayanabbad.com";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "Inter 12";
      show-battery-percentage = true;
      enable-hot-corners = false;
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
      clock-show-seconds = true;
      show-weekdate = true;
    };
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/rayanalabbad/Pictures/wallpaper.png";
      picture-uri-dark = "file:///home/rayanalabbad/Pictures/wallpaper.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/rayanalabbad/Pictures/wallpaper.png";
      picture-uri-dark = "file:///home/rayanalabbad/Pictures/wallpaper.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/peripheral/mouse" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-fullscreen = [ "<Super>f" ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "LEFT";
      intellihide-mode = "ALL_WINDOWS";
      show-trash = false;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "zen-beta.desktop"
        "vesktop.desktop"
	"davinci-resolve.desktop" 
        "com.mitchellh.ghostty.desktop" 
      ];
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
