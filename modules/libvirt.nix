{
  pkgs,
  lib,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.qemu = {
  swtpm.enable = true;
};
  virtualisation.spiceUSBRedirection.enable = true;
  users.extraGroups.libvirtd.members = ["ahi"];
}
