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
            font-family = "Hack Nerd Font Mono";
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

    dconf.settings = {
        "org/gnome/desktop/interface" = {
            font-name = "Inter 12";
            show-battery-percentage = true;
            enable-hot-corners = false;
            color-scheme = "prefer-dark";
            clock-show-weekday = true;
            clock-show-seconds = true;
            show-weekdate = true;
            icon-theme = "Papirus";
            cursor-theme = "macOS";
#gtk-theme = "Tokyonight-Dark";
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
        "org/gnome/desktop/input-sources" = {
            show-all-sources = true;
            sources = [
                (lib.gvariant.mkTuple [ "xkb" "us" ])
                    (lib.gvariant.mkTuple [ "xkb" "de" ])
                    (lib.gvariant.mkTuple [ "xkb" "ara" ])
            ];
            xkb-options = [ "terminate:ctrl_alt_bksp" "grp:alt_shift_toggle" ];
        };
        "org/gnome/shell/extensions/user-theme" = {
#name = "Tokyonight-Dark";
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
                "firefox.desktop"
                    "vesktop.desktop"
                    "davinci-resolve.desktop" 
                    "com.mitchellh.ghostty.desktop" 
            ];
            enabled-extensions = with pkgs.gnomeExtensions; [
                dash-to-dock.extensionUuid
                blur-my-shell.extensionUuid
                user-themes.extensionUuid
            ];
        };
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
