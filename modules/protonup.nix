{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    protonup
  ];

}
