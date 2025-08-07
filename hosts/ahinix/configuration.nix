# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    inputs.home-manager.nixosModules.default
    ../../modules/warp.nix
    ../../modules/no-middle-click-paste.nix
    ../../modules/plymouth.nix
    ../../modules/kde-connect.nix
    ../../modules/zed.nix
    ../../modules/activate-linux.nix
    # ../../modules/virtualbox.nix
  ];

  nixpkgs.overlays = [
    (import ../../overlays/pkgs/gnome-backgrounds/default.nix) # custom wallpapers
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ahinix"; # Define your hostname.

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking
  networking.networkmanager.enable = true;

  networking.timeServers = ["time.fi.muni.cz"];

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "cs_CZ.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Systray icons udev rules
  # https://nixos.wiki/wiki/GNOME#Systray_Icons
  services.udev.packages = with pkgs; [gnome-settings-daemon];

  services.flatpak.enable = true;

  # https://nixos.wiki/wiki/GNOME#Excluding_some_GNOME_applications_from_the_default_install
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    yelp # gnome help
    geary # email reader
    gnome-contacts
    totem # video player
  ];

  # Enable GNOME/Google account integration
  services.accounts-daemon.enable = true;
  services.gnome.gnome-online-accounts.enable = true;

  # Enable GStreamer in Nautilus
  # https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1278954466
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    #  pkgs.gst_all_1.gst-plugins-libav
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cz";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "cz-lat2";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [hplipWithPlugin];

  # Enable SANE to scan documents.
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [pkgs.hplipWithPlugin];

  # Enable sound with pipewire.
  # sound.enable = true;
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

  # Video acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
    # NIXOS_OZONE_WL = "1"; # https://wiki.nixos.org/wiki/Wayland#Electron_and_Chromium
  };

  # Enable xpadneo driver for Bluetooth Xbox One controller support
  hardware.xpadneo.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ahi = {
    isNormalUser = true;
    description = "ahi";
    extraGroups = ["networkmanager" "scanner" "wheel" "lp"];
    packages = with pkgs; [
      vesktop
      obsidian
      onlyoffice-bin_latest
      yt-dlp
      youtube-music
      shortwave # gtk+ internet radio
      celluloid # gtk+ mpv frontend
      mission-center # resource usage monitor
      hieroglyphic # LaTeX symbol finder
      foliate # e-book reader
      nix-your-shell # nix-shell fish support
      fzf
      bat
      just
      prismlauncher
      smile # emoji picker
      gnome-randr # display rotation cli
      ffmpeg
    ];
  };

  fonts.packages = with pkgs; [
    corefonts
  ];
  # Enable NixOS to use fonts from ~/.local/share/fonts
  fonts.fontDir.enable = true;

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "ahi" = import ../../home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      git
      gnupg
      pinentry
      gnome-tweaks
      tre-command
      zoxide
      libnotify
      hunspellDicts.cs-cz
      ffmpeg
      firefox
    ]
    ++ (with gnomeExtensions; [
      appindicator
      dash-to-dock
      night-theme-switcher
      custom-hot-corners-extended
      focused-window-d-bus
      window-title-is-back
      xwayland-indicator
      mpris-label
      tiling-shell
      foresight
      caffeine
      light-style
    ]);

  # security.sudo-rs.enable = true;

  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   # Add any missing dynamic libraries for unpackaged
  #   # programs here, NOT in environment.systemPackages
  # ];

  programs.fish.enable = true;
  programs.direnv.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    #   enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.avahi = {
    nssmdns4 = true;
    nssmdns6 = true;
    enable = true;
    ipv4 = true;
    ipv6 = true;
  };

  # Disable fwupd, don't need it
  services.fwupd.enable = false;

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
  system.stateVersion = "23.11"; # Did you read the comment?
}
