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
    fonts = {
      fixedWidth = {
        family = "Cascadia Mono";
        pointSize = 10;
      };
      general = {
        family = "Cascadia Mono";
        pointSize = 10;
      };
      menu = {
        family = "Cascadia Mono";
        pointSize = 10;
      };
      small = {
        family = "Cascadia Mono";
        pointSize = 8;
      };
      toolbar = {
        family = "Cascadia Mono";
        pointSize = 10;
      };
      windowTitle = {
        family = "Cascadia Mono";
        pointSize = 10;
      };
    };
    workspace = {
      cursor = {
        size = 24;
        theme = "Bibata-Modern-Ice";
      };
      wallpaperPictureOfTheDay.provider = "bing";
      wallpaperFillMode = "preserveAspectCrop";
    };
    configFile = {
      "klipperrc"."General"."IgnoreImages" = false;
      "klipperrc"."General"."MaxClipItems" = 2048;
      "ksmserverrc"."General"."loginMode" = "emptySession";
      "kwinrc"."Xwayland"."Scale" = 1.25;
      "plasmaparc"."General"."AudioFeedback" = false;
      "spectaclerc"."General"."autoSaveImage" = true;
      "spectaclerc"."General"."clipboardGroup" = "PostScreenshotCopyImage";
      "spectaclerc"."General"."useReleaseToCapture" = true;
    };
    shortcuts = {
      "kmix"."decrease_volume" = [
        "Meta+Down"
        "Volume Down"
      ];
      "kmix"."increase_volume" = [
        "Meta+Up"
        "Volume Up"
      ];
      "kwin"."Window Close" = [
        "Meta+Q"
        "Alt+F4"
      ];
      "mediacontrol"."nextmedia" = [
        "Meta+L"
        "Media Next"
      ];
      "mediacontrol"."playpausemedia" = [
        "Meta+K"
        "Media Play"
      ];
      "mediacontrol"."previousmedia" = [
        "Meta+J"
        "Media Previous"
      ];
      "org_kde_powerdevil"."Decrease Screen Brightness" = "Meta+Left";
      "org_kde_powerdevil"."Increase Screen Brightness" = "Meta+Right";
    };
  };
}
