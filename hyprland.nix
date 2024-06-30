{ config, pkgs, ... }:

{
  # Specify system packages needed by Hyprland and other applications
  environment.systemPackages = with pkgs; [
    # System Packages
    baobab
    btrfs-progs
    cpufrequtils
    duf
    ffmpeg   
    glib
    hwdata
    hyfetch
    inxi  
    libappindicator
    libnotify
    openssl
    vim
    wget
    xdg-user-dirs

    # Additional packages specific to Hyprland or user's setup
    audacious
    fastfetch
    (mpv.override { scripts = [ mpvScripts.mpris ]; }) # assuming you have mpvScripts defined
    ranger
    ags
    btop
    cava
    cliphist
    gnome.eog
    gnome.gnome-system-monitor
    gnome.file-roller
    grim
    gtk-engine-murrine
    hyprcursor
    hypridle
    imagemagick
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum
    networkmanagerapplet
    nwg-look
    nvtopPackages.full
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    qt5ct
    qt6ct
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    rofi-wayland
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    wl-clipboard
    wlogout
    yad
    wallust
  ];

  # Configure specific programs and services related to Hyprland
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;  # Adjust if hyprland is provided differently
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  # Other program configurations
  programs = {
    xwayland.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    git.enable = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
    dconf.enable = true;
    waybar.enable = true;
  };

  # Services configuration
  services = {
    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    fwupd.enable = true;

    upower.enable = true;
  };

  # Fonts configuration
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk
    jetbrains-mono
    font-awesome
    terminus_font
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  # Security settings
  security = {
    pam.services.swaylock.text = "auth include login";
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Systemd services
  systemd.services = {
    NetworkManager-wait-online.enable = false;
    firewalld.enable = false;  # Exclude firewall configuration
    power-profiles-daemon = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
    };
  };

  # Additional configurations as needed
}
