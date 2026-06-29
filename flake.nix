{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    activate-linux.url = "github:ahi6/activate-linux";
    # activate-linux.url = "github:MrGlockenspiel/activate-linux";
    # activate-linux.url = "github:Kaisia-Estrel/activate-linux"; # rust version, incompatible with gnome

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      #  inputs.nixpkgs.follows = "nixpkgs";
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
      # ...
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
      # ...
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        activate-linux-pkg = activate-linux.packages.${system}.default;
      };
      modules = [
        {nixpkgs.overlays = [nur.overlays.default];}
        ./hosts/tvo/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
