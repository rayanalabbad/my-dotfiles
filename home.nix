{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./nvim.nix
  ];

  home.stateVersion = "24.05";
  home.username = "rayanalabbad";
  home.homeDirectory = "/Users/rayanalabbad";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # -----------------------------
  # Packages
  # -----------------------------

  home.packages = with pkgs; [
    # shell tools
    fastfetch
    hyfetch
    btop
    cmatrix
    asciiquarium-transparent

    # utilities
    eza
    fd
    ripgrep
    fzf
    zoxide
    yazi
    defaultbrowser

    # development tools
    gh
    cargo
    rustc
    rust-analyzer

    # build tools
    gcc
    gdb
    lldb
    cmake
    gnumake
    ninja

    # formatters
    nixfmt
    prettier
    rustfmt
    clang-tools

    # utilities
    vlc-bin
    libreoffice-bin
  ];

  # -----------------------------
  # Git
  # -----------------------------
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Rayan Alabbad";
        email = "rayan@rayanabbad.com";
      };
      init.defaultBranch = "main";
    };
  };

  # -----------------------------
  # Shell
  # -----------------------------
  programs.starship.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      style = "plain";
      theme = "TwoDark";
    };
  };

  programs.fish = {
    enable = true;
    package = pkgs.fish;
    shellAliases = {
      ls = "eza";
      ll = "eza -lah";
      vim = "nvim";
      cd = "z";
      drb = "darwin-rebuild build --flake ~/nix-config";
      drs = "sudo darwin-rebuild switch --flake ~/nix-config";
      nfu = "nix flake update ~/nix-config";
      cat = "bat";
      g = "git";
      gs = "git status";
      ga = "git add";
      gaa = "git add .";
      gc = "git commit";
      gcm = "git commit -m";
      gco = "git checkout";
      gp = "git push";
      gpup = "git push -u origin HEAD";
      gl = "git pull";
      gd = "git diff";
    };

    interactiveShellInit = "";
  };

  # -----------------------------
  # Ghostty
  # -----------------------------
  programs.ghostty = {
    enable = true;
    package = null;

    settings = {
      theme = "TokyoNight";
      window-padding-x = 5;
      window-padding-y = 5;
      background-opacity = 0.4;
      background-blur = true;
      macos-titlebar-style = "hidden";
    };
  };

  #------------------------------
  # BTOP
  #------------------------------
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Default";
      theme_background = false;
    };
  };

  # -----------------------------
  # MIME fix
  # -----------------------------
  xdg.configFile."mimeapps.list" = {
    force = true;
    text = "";
  };

  # -----------------------------
  # Fastfetch
  # -----------------------------

  programs.fastfetch = {
    enable = true;
    settings = {
      logo.padding.top = 2;
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "lm"
        "de"
        "wm"
        "terminal"
        "terminalfont"
        {
          type = "cpu";
          showPeCoreCount = true;
          temp = true;
        }
        "memory"
        "disk"
        "break"
        "colors"
      ];
    };
  };

  # -----------------------------
  # TMUX
  # -----------------------------
  programs.tmux = {
    enable = true;
    clock24 = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    plugins = with pkgs; [
      tmuxPlugins.tokyo-night-tmux
    ];
    extraConfig = ''
      set -g prefix C-a
      unbind C-b
      bind C-a send-prefix
      set -g mouse on
      bind r source-file ~/.tmux.conf
      set -g pane-border-lines single
    '';
  };

  #------------------------------
  # direnv
  #------------------------------
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}
