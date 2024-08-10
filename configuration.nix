{ config, pkgs, inputs, lib, ... }: let
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
      ]
  	);
  in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/hardware/nvidia.nix
    #  ./modules/docker.nix
      ./modules/flatpak.nix
    #  ./system/wm/kde6.nix # needs unstable channel
      ./system/wm/gnome.nix
    #  ./hyprland.nix
      ./system/wm/dbus.nix
    #  ./system/wm/fonts.nix
      ./system/wm/pipewire.nix
      ./system/wm/x11.nix
      ./system/hardware/opengl.nix
    #  ./devices/kevin-desktop.nix # Gaming pc
    #  ./devices/kevin-asus.nix #Asus zenbook notebook
       ./podman.nix
    #   ./home.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  fileSystems."/datalinux" = {
    device = "/dev/disk/by-uuid/fc337e71-6213-429d-aeb7-38ff3dc35aa6";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kevin = {
    isNormalUser = true;
    description = "Kevin";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    brave
      ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  git
#  pciutils
  pkgs.distrobox
  pkgs.boxbuddy
  syncthing
  nvidia-container-toolkit
  ];

services = {
    syncthing = {
        enable = true;
        user = "kevin";
        dataDir = "/home/kevin/Documents";    # Default folder for new synced folders
        configDir = "/home/kevin/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
};

# For a newer kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.nvidia-container-toolkit.enable = true;


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
