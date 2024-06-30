# modules/opengl.nix
{ pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;  # Adjusted from hardware.opengl.enable
    enable32Bit = true;  # Adjusted from hardware.opengl.driSupport32Bit
  };
}
