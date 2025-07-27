# based on https://github.com/Cryolitia/nixos-config/blob/fc8f74345bfc8e8538dc895515024f69c80cc99e/graphic/software/activate-linux.nix
{
  pkgs,
  lib,
  activate-linux-pkg,
  ...
}: {
  systemd.user.services.activate-linux = {
    description = "Activate NixOS";
    wantedBy = ["graphical-session.target"];
    path = [activate-linux-pkg];
    serviceConfig = {
      ExecStartPre = ''
        ${pkgs.coreutils-full}/bin/sleep 30
      '';
      ExecStart = ''
        ${lib.getExe activate-linux-pkg} -t "Activate NixOS" -m "Go to Settings to activate NixOS"
      '';
      Restart = "on-failure";
      RestartSec = 30;
    };
  };
}
