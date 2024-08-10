{
  description = "My first flake!";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # development or -git version 
    wallust.url = "git+https://codeberg.org/explosion-mental/wallust?ref=dev"; # change to dev or master depending your choice
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # Adding Chaotic-Nyx repository

  };

  outputs = { self, nixpkgs, home-manager, chaotic, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            chaotic.nixosModules.default # Chaotic-Nyx default module

          ];
        };
      };
      homeConfigurations = {   
        kevin = home-manager.lib.homeManagerConfiguration {
          inherit pkgs; 
          modules = [ ./home.nix ];
        };
      };
    };
}

