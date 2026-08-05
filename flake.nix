{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    ahi-nixpkgs = {
      url = "github:ahi6/nixpkgs?ref=update-handheld-daemon";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    activate-linux.url = "github:MrGlockenspiel/activate-linux";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    activate-linux,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.ahinix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        activate-linux-pkg = activate-linux.packages.${system}.default;
      };
      modules = [
        {nixpkgs.overlays = [nur.overlays.default];}
        ./hosts/ahinix/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.tvo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        activate-linux-pkg = activate-linux.packages.${system}.default;
      };
      modules = [
        {
          nixpkgs.overlays = [
            nur.overlays.default
            (final: prev: {
              handheld-daemon = inputs.ahi-nixpkgs.legacyPackages.${prev.stdenv.hostPlatform.system}.handheld-daemon;
            })
          ];
        }
        ./hosts/tvo/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
