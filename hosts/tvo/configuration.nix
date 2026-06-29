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

  networking.hostName = "tvo";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.uinput.enable = true;

  users.users.ahi.extraGroups = ["input" "uinput" "video"];

  boot.blacklistedKernelModules = ["hid_lenovo_go_s"]; # needed for hhd 4.1.9 on Linux 7.1+

  services.handheld-daemon.enable = true;
  services.handheld-daemon.user = "ahi";
  services.handheld-daemon.ui.enable = true;
}
