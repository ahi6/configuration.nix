{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cloudflare-warp
  ];
  systemd.packages = [pkgs.cloudflare-warp]; # warp
  systemd.targets.multi-user.wants = ["warp-svc.service"]; # causes warp-svc to be started automatically
}
