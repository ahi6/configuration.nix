{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    activate-linux.url = "github:ahi6/activate-linux";
    # activate-linux.url = "github:MrGlockenspiel/activate-linux";
    # activate-linux.url = "github:Kaisia-Estrel/activate-linux"; # rust version, incompatible with gnome

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    alejandra,
    activate-linux,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    #nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    #    specialArgs = {inherit inputs;};
    #    modules = [
    #     ./configuration.nix
    #     inputs.home-manager.nixosModules.default
    #   ];
    # };

    nixosConfigurations.ahinix = nixpkgs.lib.nixosSystem {
      # ...
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        activate-linux-pkg = activate-linux.packages.${system}.default;
      };
      modules = [
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }

        {nixpkgs.overlays = [nur.overlays.default];}
        ./hosts/ahinix/configuration.nix
        inputs.home-manager.nixosModules.default
        # nixos-hardware.nixosModules.dell-latitude-5520 # fixed graphics-drivers on 24.11.20241018.4c2fcb0
      ];
    };
  };
}
