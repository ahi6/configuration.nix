{
  pkgs,
  lib,
  ...
}: let
  python = pkgs.python313.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      edulint = pyfinal.callPackage ../packages/edulint.nix {};
    };
  };

  munipkgs = with pkgs; {
    pb015 = [
      haskell.compiler.ghcHEAD # aisa has version 9.2.1, but whatever
    ];
    ib111 = [
      (python.withPackages (python-pkgs:
        with python-pkgs; [
          tkinter
          edulint
        ]))
      mypy
      ruff
      thonny
    ];
  };
in {
  # NTP
  networking.timeServers = ["time.fi.muni.cz"];

  environment.systemPackages = munipkgs.pb015 ++ munipkgs.ib111;
}
