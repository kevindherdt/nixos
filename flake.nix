{
  description = "My first flake!";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # development or -git version 
    wallust.url = "git+https://codeberg.org/explosion-mental/wallust?ref=dev"; # change to dev or master depending your choice
  };

  outputs = { self, nixpkgs, home-manager, ... }:
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

