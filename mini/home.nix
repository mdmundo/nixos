{
  config,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "edmundo";
  home.homeDirectory = "/home/edmundo";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.plasma = {
    enable = true;
    input.keyboard.numlockOnStartup = "on";
    kscreenlocker = {
      appearance.wallpaperPictureOfTheDay.provider = "bing";
      autoLock = false;
    };
    workspace = {
      wallpaperPictureOfTheDay.provider = "bing";
      wallpaperFillMode = "preserveAspectCrop";
    };
    configFile = {
      "klipperrc"."General"."IgnoreImages" = false;
      "klipperrc"."General"."MaxClipItems" = 2048;
    };
  };
}
