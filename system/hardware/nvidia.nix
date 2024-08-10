# modules/gnome.nix

{ config, pkgs, ... }:

boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

{
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
