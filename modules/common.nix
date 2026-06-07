{ pkgs, nur, ... }:
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
}
