{
  config,
  pkgs,
  updates,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "edmundo";
  home.homeDirectory = "/home/edmundo";

  # Packages that should be installed to the user profile.
  home.packages = [ pkgs.hello ];

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
      "org_kde_powerdevil"."Decrease Screen Brightness" = "Meta+Left,Monitor Brightness Down";
      "org_kde_powerdevil"."Increase Screen Brightness" = "Meta+Right,Monitor Brightness Up";
      "kmix"."decrease_volume" = "Meta+Down,Volume Down";
      "kmix"."increase_volume" = "Meta+Up,Volume Up";
      "kwin"."Window Close" = "Meta+Q,Alt+F4";
      "mediacontrol"."previousmedia" = "Meta+J,Media Previous";
      "mediacontrol"."playpausemedia" = "Meta+K,Media Play";
      "mediacontrol"."nextmedia" = "Meta+L,Media Next";
    };
    configFile = {
      "klipperrc"."General"."IgnoreImages" = false;
      "klipperrc"."General"."MaxClipItems" = 2048;
      "kscreenlockerrc"."Daemon"."Autolock" = false;
      "kscreenlockerrc"."Daemon"."LockGrace" = 0;
    };
  };
}
