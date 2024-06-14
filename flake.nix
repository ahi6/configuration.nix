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
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    alejandra,
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
      specialArgs = {inherit inputs;};
      modules = [
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }

        # ...
        # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        ./hosts/ahinix/configuration.nix
        inputs.home-manager.nixosModules.default
        nixos-hardware.nixosModules.dell-latitude-5520
      ];
    };
  };
}
