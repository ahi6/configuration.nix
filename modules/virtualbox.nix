{
  pkgs,
  lib,
  ...
}: {
  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableKvm = true;
  # virtualisation.virtualbox.host.addNetworkInterface = false;
  users.extraGroups.vboxusers.members = ["ahi6"];
}
