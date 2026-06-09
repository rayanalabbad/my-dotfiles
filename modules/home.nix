{ pkgs, inputs, lib, isDarwin, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./nvim.nix
  ] ++ lib.optionals isDarwin [
    ./macos.nix
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
    tree
    lazygit

    # development tools
    gh
    cargo
    rustc
    python3
    bun
    typescript
    nodejs
    vitejs
    tailwindcss
    go
    lua
    love

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
    tree-sitter
    stylua

    # language-servers
    svelte-language-server
    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    lua-language-server
    rust-analyzer
    nixd

    # apps
    audacity
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

  # -----------------------------
  # helix
  # -----------------------------
  programs.helix = {
    enable = true;

    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        soft-wrap.enable = true;
        auto-completion = true;
        auto-format = true;
        completion-trigger-len = 1;
        true-color = true;
        file-picker.hidden = false;
      };
    };

    languages = {
      language-server = {
        nixd = {
          command = "nixd";
        };
        svelte-language-server = {
          command = "svelteserver";
          args = [ "--stdio" ];
        };
        tailwindcss = {
          command = "tailwindcss-language-server";
          args = [ "--stdio" ];
        };
        eslint = {
          command = "vscode-eslint-language-server";
          args = [ "--stdio" ];
        };
        clangd = {
          command = "clangd";
          args = [ "--query-driver=/run/current-system/sw/bin/g++,**/g++" ];
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
          language-servers = [ "nixd" ];
        }
        {
          name = "svelte";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "html"
            ];
          };
          language-servers = [
            "svelte-language-server"
            "tailwindcss"
            "eslint"
          ];
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
          language-servers = [
            "typescript-language-server"
            "tailwindcss"
            "eslint"
          ];
        }
        {
          name = "javascript";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "babel"
            ];
          };
          language-servers = [
            "typescript-language-server"
            "tailwindcss"
            "eslint"
          ];
        }
        {
          name = "css";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "css"
            ];
          };
          language-servers = [
            "vscode-css-language-server"
            "tailwindcss"
          ];
        }
        {
          name = "html";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "html"
            ];
          };
          language-servers = [
            "vscode-html-language-server"
            "tailwindcss"
          ];
        }
        {
          name = "json";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "json"
            ];
          };
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "c";
          language-servers = [ "clangd" ];
        }
        {
          name = "cpp";
          language-servers = [ "clangd" ];
        }
      ];
    };
  };

  #------------------------------
  # direnv
  #------------------------------
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}
