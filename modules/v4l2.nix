{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];
  boot.kernelModules = [
    "v4l2loopback"
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 max_buffers=2
  '';
  # exclusive_caps       electron / chromium support
  # max_buffers          multiple receiving apps

  environment.systemPackages = with pkgs; [
    v4l-utils
  ];
}
