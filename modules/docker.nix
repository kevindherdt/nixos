# modules/docker.nix

{ config, pkgs, ... }:

{
  # Enable docker
  virtualisation.docker.enable = true;

  # Use docker without Root access
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
