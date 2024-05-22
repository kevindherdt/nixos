{ config, pkgs, lib, ... }:

let
  nvidiaVersion = "555.42.02";
  nvidiaSha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
  nvidiaSha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
  nvidiaOpenSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
  nvidiaSettingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
in
{
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = nvidiaVersion;
      sha256_64bit = nvidiaSha256_64bit;
      sha256_aarch64 = nvidiaSha256_aarch64;
      openSha256 = nvidiaOpenSha256;
      settingsSha256 = nvidiaSettingsSha256;
      persistencedSha256 = lib.fakeSha256;
    };
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
}
