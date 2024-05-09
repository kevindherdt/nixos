{ config, pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # System Packages
    baobab
    btrfs-progs
    cpufrequtils
    ffmpeg   
    glib #for gsettings to work   
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    python3 
    vim
    wget
    xdg-user-dirs

    # I normally have and use
    audacious
    mpv
    neofetch
    ranger
    shotcut
	    
    # Hyprland Stuff        
    btop
    cava
    cliphist
    gnome.eog
    gnome.gnome-system-monitor
    gnome.file-roller
    grim
    gtk-engine-murrine #for gtk themes
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    hyprlock  # requires unstable channel
    jq
    kitty
    mpvScripts.mpris
    networkmanagerapplet
    nwg-look # requires unstable channel
    nvtopPackages.full
    pamixer
    pavucontrol
    polkit_gnome
    pywal
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum #kvantum
    libsForQt5.qtstyleplugin-kvantum #kvantum
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    qt5ct
    qt6ct
    rofi-wayland
    wl-clipboard
    wlogout
    yad
  ];

  programs = {
    # Enable Hyprland environment
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Enable Waybar conditionally based on the Hyprland environment
    waybar = {
      enable = config.programs.hyprland.enable;
    };

    # Enable other programs as needed
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
  };

  # Enable XDG portal and specify extra portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
  
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

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk
    jetbrains-mono
    font-awesome
    terminus_font
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  security = {
    pam.services.swaylock.text = "auth include login";
    polkit.enable = true;
    rtkit.enable = true;
  };
}
