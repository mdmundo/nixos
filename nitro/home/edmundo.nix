{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "edmundo";
  home.homeDirectory = "/home/edmundo";

  # Packages that should be installed to the user profile.
  home.packages = [ pkgs.deno ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.plasma = {
    enable = true;
    shortcuts = {
      "kmix"."decrease_volume" = "Meta+Down,Volume Down,Decrease Volume";
      "kmix"."increase_volume" = "Meta+Up,Volume Up,Increase Volume";
      "ksmserver"."Log Out" = "Meta+Del,Ctrl+Alt+Del,Log Out";
      "kwin"."Window Close" = "Meta+Q,Alt+F4,Close Window";
      "kwin"."Window Maximize" = "Meta+PgUp";
      "kwin"."Window Minimize" = "Meta+PgDown";
      "mediacontrol"."nextmedia" = "Meta+L,Media Next,Media playback next";
      "mediacontrol"."playpausemedia" = "Meta+K,Media Play,Play/Pause media playback";
      "mediacontrol"."previousmedia" = "Meta+J,Media Previous,Media playback previous";
      "org_kde_powerdevil"."Decrease Screen Brightness" = "Meta+Left,Monitor Brightness Down,Decrease Screen Brightness";
      "org_kde_powerdevil"."Increase Screen Brightness" = "Meta+Right,Monitor Brightness Up,Increase Screen Brightness";
      "plasmashell"."show-on-mouse-pos" = "Meta+V";
    };
    configFile = {
      "klipperrc"."General"."IgnoreImages" = false;
      "klipperrc"."General"."MaxClipItems" = 2048;
      "kscreenlockerrc"."Daemon"."Autolock" = false;
      "kscreenlockerrc"."Daemon"."LockGrace" = 0;
    };
  };
}
