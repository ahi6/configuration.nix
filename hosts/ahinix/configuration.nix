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
    ../common/configuration.nix
  ];

  networking.hostName = "ahinix"; # Define your hostname.

  # Video acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
    GSK_RENDERER = "gl"; # force opengl renderer in GTK4 apps to fix graphical errors
    # NIXOS_OZONE_WL = "1"; # https://wiki.nixos.org/wiki/Wayland#Electron_and_Chromium
  };
}
