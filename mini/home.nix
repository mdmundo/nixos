{ config, pkgs, ... }:

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
    # overrideConfig = true;
    input = {
      keyboard.numlockOnStartup = "on";
      mice = [
        {
          enable = true;
          leftHanded = true;
          name = "PixArt Microsoft USB Optical Mouse";
          productId = "00cb";
          vendorId = "045e";
        }
      ];
    };
    panels = [
      {
        alignment = "left";
        floating = true;
        height = 44;
        hiding = "none";
        lengthMode = "fill";
        location = "bottom";
      }
    ];
    kscreenlocker = {
      appearance.wallpaperPictureOfTheDay.provider = "bing";
      autoLock = false;
    };
    workspace = {
      cursor = {
        size = 24;
        theme = "Bibata-Modern-Ice";
      };
      wallpaperPictureOfTheDay.provider = "bing";
      wallpaperFillMode = "preserveAspectCrop";
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
    configFile = {
      "klipperrc"."General"."IgnoreImages" = false;
      "klipperrc"."General"."MaxClipItems" = 256;
      "ksmserverrc"."General"."loginMode" = "emptySession";
      "kwinrc"."Effect-overview"."BorderActivate" = 9;
      "kwinrc"."Plugins"."shakecursorEnabled" = false;
      "kwinrc"."TabBox"."LayoutName" = "compact";
      "kwinrc"."TabBox"."OrderMinimizedMode" = 1;
      "kwinrc"."Xwayland"."Scale" = 1.25;
      "plasmanotifyrc"."Notifications"."PopupPosition" = "BottomRight";
      "plasmaparc"."General"."AudioFeedback" = false;
      "spectaclerc"."General"."autoSaveImage" = true;
      "spectaclerc"."General"."clipboardGroup" = "PostScreenshotCopyImage";
      "spectaclerc"."General"."useReleaseToCapture" = true;
    };
    shortcuts = {
      "ksmserver"."Halt Without Confirmation" = "Meta+Del";
      "ksmserver"."Reboot Without Confirmation" = "Meta+Shift+Del";
      "kmix"."decrease_volume" = [
        "Meta+Down"
        "Volume Down"
      ];
      "kmix"."increase_volume" = [
        "Meta+Up"
        "Volume Up"
      ];
      "kwin"."Kill Window" = "Meta+X";
      "kwin"."Window Close" = [
        "Meta+Q"
        "Alt+F4"
      ];
      "mediacontrol"."nextmedia" = [
        "Meta+Shift+Right"
        "Media Next"
      ];
      "mediacontrol"."playpausemedia" = [
        "Meta+Shift+Down"
        "Media Play"
      ];
      "mediacontrol"."previousmedia" = [
        "Meta+Shift+Left"
        "Media Previous"
      ];
      "org_kde_powerdevil"."Decrease Screen Brightness" = "Meta+Left";
      "org_kde_powerdevil"."Increase Screen Brightness" = "Meta+Right";
      "org_kde_powerdevil"."Sleep" = "Meta+Ins";
      "services/org.kde.spectacle.desktop"."RectangularRegionScreenShot" = "Meta+S";
    };
  };
}
