# modules/gnome.nix

{ config, pkgs, ... }:

{
  #  Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
 
  environment.systemPackages = [
  # the rest of my packages

  pkgs.gnome-tweaks
];

}
