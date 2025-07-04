# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Riyadh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,de,ara";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rayanalabbad = {
    isNormalUser = true;
    description = "Rayan Alabbad";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.shellAliases = {
    ls = "eza";
    cd = "z";
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    vim
    neovim
    helix
    wl-clipboard
    wget
    fastfetch
    htop
    btop
    cmatrix
    git
    gh
    fish
    starship
    yazi
    fzf
    zoxide
    eza
    bat
    dipc
    dconf2nix
    firebase-tools
    http-server
    # GPU
    vulkan-tools
    glxinfo
    mesa
    libva
    intel-media-driver
    intel-compute-runtime
    intel-graphics-compiler
    opencl-headers
    ocl-icd
    intel-ocl
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    # Gnome
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    gnomeExtensions.search-light
    papirus-icon-theme
    apple-cursor
    gnome-tweaks
    tokyonight-gtk-theme
    # Tmux
    tmux
    tmuxPlugins.sensible
    tmuxPlugins.tokyo-night-tmux
    # Fonts
    hack-font
    inter
    corefonts
    vista-fonts
    wineWow64Packages.fonts
    google-fonts
    # Compilers
    gcc
    libgccjit
    rocmPackages.llvm.clang-unwrapped
    binutils
    rustup
    rustc
    cargo
    python3
    jdk
    go
    sqlite
    elixir
    # Language servers
    beamMinimal28Packages.elixir-ls
    clang-tools
    typescript-language-server
    vscode-langservers-extracted
    # Web development
    bun
    nodejs_24
    prettier
    # Graphic Design
    gimp3
    inkscape-with-extensions
    krita
    audacity
    blender
    # Desktop applications
    ghostty
    discord
    vesktop
    firefox
    davinci-resolve
    eyedropper
    vlc
    qalculate-gtk
    inputs.zen-browser.packages."${system}".default
    libreoffice-qt6-fresh
    sqlitebrowser
    kdePackages.dolphin
    thunderbird
    kdePackages.kate
    speedcrunch
  ];

  environment.gnome.excludePackages = with pkgs; [
    nautilus
    geary
    gnome-contacts
    gnome-calendar
    epiphany
    gnome-software
    gnome-text-editor
    gnome-calculator
    gnome-tour
    gnome-console
    totem
    gnome-maps
  ];

  fonts.enableDefaultPackages = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  documentation.man.generateCaches = false;
  services.flatpak.enable = true;

  #programs.tmux = {
  #  enable = true;
  #  clock24 = true;
  #  extraConfig = '' 
  #    set -g default-terminal "xterm-256color"
  #    set-option -sa terminal-features ',xterm-256color:RGB'
  #    set-option -g default-terminal "tmux-256color"
  #    set-option -ga terminal-features ",xterm-256color:usstyle"
  #    set -g mouse on 
  #    set -g @plugin 'tmux-plugins/tmux-sensible'
  #    set -g @plugin janoamaral/tokyo-night-tmux'
  #    unbind C-b
  #    set-option -g prefix C-a
  #    bind-key C-a send-prefix
  #    set-option -g allow-rename off
  #  '';
  #};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
