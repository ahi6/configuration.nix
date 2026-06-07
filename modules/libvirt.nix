{
  pkgs,
  lib,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.extraGroups.vboxusers.members = ["ahi"];
}
