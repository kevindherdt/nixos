# modules/opengl.nix
{ pkgs, ... }:

{
  # Enable Opengl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
}
