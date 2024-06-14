{
  pkgs,
  lib,
  ...
}: {
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
    ];
  };

  users.users.ahi = {
    packages = with pkgs; [
      davinci-resolve
    ];
  };
}
