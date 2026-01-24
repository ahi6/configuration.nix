{
  pkgs,
  lib,
  ...
}: let
  munipkgs = with pkgs; {
    pb015 = [
      haskell.compiler.ghcHEAD # aisa has version 9.2.1, but whatever
      haskell-language-server
      swi-prolog-gui
    ];
    ib111 = [
      (python313.withPackages (python-pkgs:
        with python-pkgs; [
          tkinter
          nur.repos.ahi6.edulint
        ]))
      mypy
      ruff
      thonny
      hyperfine # code benchmarking
    ];
    #    pb111 = [   # tinycc is AISA exclusive, so i cannot work locally
    #      python313 # tinyvm
    #    ];
    ib002 = [
      python313
      mypy
      python313Packages.flake8
    ];
  };
in {
  # NTP
  networking.timeServers = ["time.fi.muni.cz"];

  # environment.systemPackages = munipkgs.pb015 ++ munipkgs.ib111; # fall 2025
  environment.systemPackages = munipkgs.ib002; # spring 2026
}
