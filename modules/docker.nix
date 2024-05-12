# modules/docker.nix

{ config, pkgs, ... }:

{
  # Enable docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    enableNvidia = true;
  };

  # Use docker without Root access
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;

  };
}
