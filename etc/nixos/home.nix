{ config, inputs, pkgs, lib, ... }:

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
        home.packages = with pkgs; [
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
        MOZ_ENABLE_WAYLAND = "1";
    };

    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.apple-cursor;
        name = "Apple Cursor";
        size = 24;
    };



    programs.fish = {
        enable = true;
        shellAliases = {
            ls = "eza";
            cd = "z";
        };
        interactiveShellInit = ''
            set -g fish_greeting
            starship init fish | source
            '';
    };

    programs.ghostty = {
        enable = true;
        settings = {
            font-family = "Hack Nerd Font Mono Regular";
            font-size = "12";
            theme = "tokyonight";
# window-decoration = false;
            window-padding-y = "5";
            window-padding-x = "5";
        };
    };

    programs.zellij = {
	enableFishIntegration = true;
	settings = {
	    theme = "tokyo-night-dark";
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

    programs.zoxide = {
        enable = true;
    };

    programs.git = {
        enable = true;
        userName  = "Rayan Alabbad";
        userEmail = "rayan@rayanabbad.com";
    };

    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                id = 0;
                name = "default";
                isDefault = true;
                extensions = {
		    force = true;
                    packages = with inputs.firefox-addons.packages.${pkgs.system}; [
                        ublock-origin
			#tokyo-night-v2
                    ];
                };
                bookmarks = {
                    force = true;
                    settings = [
                    {
                        toolbar = true;
                        bookmarks = [
                        {
                            name = "yt";
                            url = "https://www.youtube.com/";
                        }
                        {
                            name = "tv";
                            url = "https://www.youtube.com/tv#/";
                        }
                        {
                            name = "note";
                            url = "https://www.notion.so/";
                        }
                        {
                            name = "gh";
                            url = "https://github.com/";
                        }
                        {
                            name = "so";
                            url = "https://stackoverflow.com/";
                        }
                        {
                            name = "mail";
                            url = "https://mail.google.com/mail/u/0/#inbox";
                        }
                        {
                            name = "365";
                            url = "https://www.office.com/";
                        }
                        {
                            name = "cal";
                            url = "https://calendar.google.com/calendar/u/0/r?pli=1";
                        }
                        {
                            name = "calc";
                            url = "https://www.desmos.com/fourfunction";
                        }
                        {
                            name = "rdt";
                            url = "https://www.reddit.com/";
                        }
                        {
                            name = "w3s";
                            url = "https://www.w3schools.com/";
                        }
                        {
                            name = "mt";
                            url = "https://monkeytype.com/";
                        }
                        {
                            name = "wk";
                            url = "https://www.wikipedia.org/";
                        }
                        {
                            name = "ttv";
                            url = "https://www.twitch.tv/";
                        }
                        {
                            name = "draw";
                            url = "https://excalidraw.com/";
                        }
                        {
                            name = "cf";
                            url = "https://codeforces.com/";
                        }
                        {
                            name = "ioi";
                            bookmarks = [
                            {
                                name = "classera";
                                url = "https://codeforces.com/";
                            }
                            {
                                name = "usaco guide";
                                url = "https://usaco.guide/";
                            }
                            {
                                name = "cses";
                                url = "https://cses.fi/";
                            }
                            {
                                name = "leetcode";
                                url = "https://leetcode.com/";
                            }
                            {
                                name = "gfg";
                                url = "https://www.geeksforgeeks.org/";
                            }
                            {
                                name = "learncpp";
                                url = "https://www.learncpp.com/";
                            }
                            {
                                name = "cpp ref";
                                url = "https://cppreference.com/";
                            }
                            {
                                name = "cplusplus";
                                url = "https://cplusplus.com/";
                            }
                            {
                                name = "mdn";
                                url = "https://developer.mozilla.org/en-US/";
                            }
                            {
                                name = "ioi";
                                url = "https://ioinformatics.org/";
                            }
                            ];
                        }
                        {
                            name = "gpt";
                            url = "https://chatgpt.com/";
                        }
                        {
                            name = "ai";
                            bookmarks = [
                            {
                                name = "poe";
                                url = "https://poe.com/";
                            }
                            {
                                name = "claude";
                                url = "https://claude.ai/new";
                            }
                            {
                                name = "gemini";
                                url = "https://gemini.google.com/app";
                            }
                            {
                                name = "deepseek";
                                url = "https://www.deepseek.com/";
                            }
                            {
                                name = "grok";
                                url = "https://grok.com/";
                            }
                            {
                                name = "notebooklm";
                                url = "https://notebooklm.google/";
                            }
                            {
                                name = "perplexity";
                                url = "https://www.perplexity.ai/";
                            }
                            ];
                        }
                        {
                            name = "lang";
                            bookmarks = [
                            {
                                name = "translate";
                                url = "https://translate.google.com/";
                            }
                            {
                                name = "deepl";
                                url = "https://www.deepl.com/en/translator";
                            }
                            {
                                name = "duo";
                                url = "https://www.duolingo.com/";
                            }
                            {
                                name = "dw german";
                                url = "https://learngerman.dw.com/en/learn-german/s-9528";
                            }
                            ];
                        }
                        {
                            name = "dc";
                            url = "https://discord.com/channels/@me";
                        }
                        {
                            name = "social";
                            bookmarks = [
                            {
                                name = "instagram";
                                url = "https://www.instagram.com/";
                            }
                            {
                                name = "tiktok";
                                url = "https://www.tiktok.com/en/";
                            }
                            {
                                name = "whatsapp";
                                url = "https://web.whatsapp.com/";
                            }
                            {
                                name = "telegram";
                                url = "https://web.telegram.org/a/";
                            }
                            ];
                        }
                        {
                            name = "other";
                            bookmarks = [
                            {
                                name = "todoist";
                                url = "https://www.todoist.com/";
                            }
                            {
                                name = "asana";
                                url = "https://asana.com/";
                            }
                            {
                                name = "maps";
                                url = "https://www.google.com/maps/";
                            }
                            {
                                name = "trello";
                                url = "https://trello.com/";
                            }
                            {
                                name = "matrix";
                                url = "https://matrix.logic-wire.de/";
                            }
                            {
                                name = "yt music";
                                url = "https://music.youtube.com/";
                            }
                            {
                                name = "old reddit";
                                url = "https://old.reddit.com/";
                            }
                            {
                                name = "keep";
                                url = "https://keep.google.com/";
                            }
                            ];
                        }
			{
			    name = "pkgs";
			    url = "https://search.nixos.org/packages";
			}
                        ];
                    }
                    ];
                };

                settings = {
                    "sidebar.verticalTabs" = true;
                    "sidebar.visibility" = "expand-on-hover";
                    "sidebar.revamp.round-content-area" = true;
                    "browser.newtabpage.enabled" = false;
                    "browser.startup.page" = 0;
                    "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
                    "browser.newtabpage.activity-stream.feeds.topsites" = false;
                    "browser.newtabpage.activity-stream.enabled" = false;
                    "browser.uidirection" = "ltr";
                    "intl.uidirection.locale" = "ltr";
                    "intl.uidirection.en" = "ltr";
                };
            };
        };
    };

    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            input = {
                touchpad = {
                    natural_scroll = "true";
                };
            };
            general = {
                gaps_in = 3;
                gaps_out = 5;
                border_size = 1;
                resize_on_border = "true";
                "col.active_border" = "rgb(555555)";
                "col.inactive_border" = "rgb(111111)";
                allow_tearing = "false";
                layout = "dwindle";
            };
            decoration = {
                rounding = 10;
                rounding_power = 2;
                active_opacity = 1.0;
                inactive_opacity = 1.0;
                shadow = {
                    enabled = "true";
                    range = 4;
                    render_power = 3;
                    color = "rgba(1a1a1aee)";
                };
                blur = {
                    enabled = "true";
                    size = 3;
                    passes = 1;
                    vibrancy = 0.1696;
                };
            };
            dwindle = {
                pseudotile = "true"; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = "true"; # You probably want this
            };
            master = {
                new_status = "master";
            };
            input = {
                kb_layout = "us,de,ara";
#kb_variant =
#kb_model =
#kb_options =
#kb_rules =
                follow_mouse = 1;
                sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
            };
            gestures = {
                workspace_swipe = "false";
            };
            animations = {
                enabled = "true";

                bezier = [
                    "easeOutQuint,0.23,1,0.32,1"
                    "easeInOutCubic,0.65,0.05,0.36,1"
                    "linear,0,0,1,1"
                    "almostLinear,0.5,0.5,0.75,1.0"
                    "quick,0.15,0,0.1,1"
                ];

                animation = [
                    "global, 1, 10, default"
                    "border, 1, 5.39, easeOutQuint"
                    "windows, 1, 4.79, easeOutQuint"
                    "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                    "windowsOut, 1, 1.49, linear, popin 87%"
                    "fadeIn, 1, 1.73, almostLinear"
                    "fadeOut, 1, 1.46, almostLinear"
                    "fade, 1, 3.03, quick"
                    "layers, 1, 3.81, easeOutQuint"
                    "layersIn, 1, 4, easeOutQuint, fade"
                    "layersOut, 1, 1.5, linear, fade"
                    "fadeLayersIn, 1, 1.79, almostLinear"
                    "fadeLayersOut, 1, 1.39, almostLinear"
                    "workspaces, 1, 1.94, almostLinear, fade"
                    "workspacesIn, 1, 1.21, almostLinear, fade"
                    "workspacesOut, 1, 1.94, almostLinear, fade"
                ];
            };
            "$mainMod" = "SUPER"; 
            "$terminal" = "ghostty";
            "$fileManager" = "dolphin";
            "$menu" = "rofi -show drun";
            env = [
                "XCURSOR_THEME,macOS"
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
            ];
            bind = [
                "$mainMod, return, exec, $terminal"
                "$mainMod, Q, killactive,"
                "$mainMod, M, exit,"
                "$mainMod, E, exec, $fileManager"
                "$mainMod, V, togglefloating,"
                "$mainMod, space, exec, $menu"
                "$mainMod, P, pseudo," # dwindle
                "$mainMod, J, togglesplit," # dwindle
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"
                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"
                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"
            ];
            bindm = [ 
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];
            /*workspace = [
                "w[tv1], gapsout:0, gapsin:0"
                "f[1], gapsout:0, gapsin:0"
            ];
            windowrule = [
                "bordersize 0, floating:0, onworkspace:w[tv1]"
                "rounding 0, floating:0, onworkspace:w[tv1]"
                "bordersize 0, floating:0, onworkspace:f[1]"
                "rounding 0, floating:0, onworkspace:f[1]"
                "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
            ];*/
            exec-once = [
                "hyprpaper"
                "hyprpanel"
            ];
            monitor = [
                ",preferred,auto,auto"
            ];
        };
    };

    services.hyprpaper = {
        enable = true;
        settings = {
            preload = [ "/home/rayanalabbad/Pictures/wallpaper.png" ];
            wallpaper = [ ",/home/rayanalabbad/Pictures/wallpaper.png" ];
            splash = false;
        };
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
