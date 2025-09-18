{
  pkgs,
  lib,
  ...
}: let
  munipkgs = with pkgs; {
    pb015 = [
      haskell.compiler.ghcHEAD # aisa has version 9.2.1, but whatever
    ];
    ib111 = [
      (python313.withPackages (python-pkgs:
        with python-pkgs; [
          tkinter
        ]))
      mypy
      ruff
    ];
  };
in {
  # NTP
  networking.timeServers = ["time.fi.muni.cz"];

  environment.systemPackages = munipkgs.pb015 ++ munipkgs.ib111;
}
