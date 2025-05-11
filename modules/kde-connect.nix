{pkgs, ...}: {
  # from https://wiki.nixos.org/wiki/KDE_Connect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
