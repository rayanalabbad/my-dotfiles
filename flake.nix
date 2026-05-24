{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    nur.url = "github:nix-community/NUR";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      nur,
      nixvim,
    }:
    let
      system = "aarch64-darwin";
      username = "rayanalabbad";

      configuration =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [
            nur.overlays.default
          ];
          environment.systemPackages = with pkgs; [
            git
            vim
            curl
            wget
            fish
          ];
          environment.shells = with pkgs; [
            bash
            zsh
            fish
          ];
          nix.settings.experimental-features = "nix-command flakes";
          nix.gc = {
            automatic = true;
            interval = {
              Weekday = 0;
              Hour = 3;
              Minute = 0;
            };
            options = "--delete-older-than 14d";
          };
          nix.settings.auto-optimise-store = true;
          nixpkgs.config.allowUnfree = true;
          programs.fish.enable = true;

          security.sudo.extraConfig = ''
            Defaults env_keep += "SHELL"
          '';

          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
            shell = pkgs.fish;
          };
          system.primaryUser = username;

          system.configurationRevision = self.rev or self.dirtyRev or null;
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          nixpkgs.hostPlatform = "aarch64-darwin";

          launchd.user.agents.raycast = {
            serviceConfig = {
              ProgramArguments = [ "/Applications/Raycast.app/Contents/MacOS/Raycast" ];
              RunAtLoad = true;
            };
          };

          security.pam.services.sudo_local.touchIdAuth = true;
          system.defaults = {
            dock.autohide = true;
            dock.persistent-apps = [
              "/Applications/Zen.app"
              "/Applications/Ghostty.app"
              "/System/Applications/Music.app"

            ];
            dock.show-recents = false;
            NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
            NSGlobalDomain.AppleShowAllExtensions = true;
            menuExtraClock.ShowSeconds = true;
            NSGlobalDomain.AppleICUForce24HourTime = true;
            universalaccess.closeViewScrollWheelToggle = true;
            universalaccess.closeViewZoomFollowsFocus = true;
            #NSGlobalDomain.AppleMenuBarVisibleInFullscreen = true;
            CustomUserPreferences = {
              NSGlobalDomain = {
                com.apple.screensaver.askForPassword = false;
                "com.apple.symbolichotkeys" = {
                  AppleSymbolicHotKeys = {
                    "64" = {
                      enabled = false;
                    };
                  };
                };
              };
              "com.raycast.macos" = {
                raycastGlobalHotkey = "Command-49";
              };
              "com.apple.WindowManager" = {
                StandardHideDesktopIcons = true;
                HideDesktop = true;
                EnableStandardClickToShowDesktop = false;
              };
              "com.apple.Stickies" = {
                ShowDesktopWidgets = false;
              };
            };
          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Rayans-MacBook-Air
      darwinConfigurations."Rayans-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = username;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              mutableTaps = false;
            };
          }
          (
            { config, ... }:
            {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
              homebrew = {
                enable = true;
                brews = [
                  "ffmpeg-full"
                ];
                casks = [
                  "zen"
                  "protonvpn"
                  "ghostty"
                  "raycast"
                ];
              };
            }
          )
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.backupFileExtension = "backup";
            home-manager.overwriteBackup = true;

            home-manager.extraSpecialArgs = {
              inherit inputs system username;
            };

            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };
    };
}

# add xcode tools and macos tools like rosetta
# add wallpaper
