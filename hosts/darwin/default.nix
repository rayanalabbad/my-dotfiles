{ pkgs, config, self, username, homebrew-core, homebrew-cask, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";

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

  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
  homebrew.enable = true;
  homebrew.brews = [ "ffmpeg-full" ];
  homebrew.casks = [
    "zen"
    "protonvpn"
    "ghostty"
    "raycast"
  ];

  launchd.user.agents.raycast = {
    serviceConfig = {
      ProgramArguments = [ "/Applications/Raycast.app/Contents/MacOS/Raycast" ];
      RunAtLoad = true;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;
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
  system.stateVersion = 6;

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
    CustomUserPreferences = {
      NSGlobalDomain = {
        com.apple.screensaver.askForPassword = false;
        "com.apple.symbolichotkeys".AppleSymbolicHotKeys."64".enabled = false;
      };
      "com.raycast.macos".raycastGlobalHotkey = "Command-49";
      "com.apple.WindowManager" = {
        StandardHideDesktopIcons = true;
        HideDesktop = true;
        EnableStandardClickToShowDesktop = false;
      };
      "com.apple.Stickies".ShowDesktopWidgets = false;
    };
  };
}
