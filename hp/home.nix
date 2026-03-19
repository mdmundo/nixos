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
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.plasma = {
    enable = true;
    overrideConfig = true;
    session.general.askForConfirmationOnLogout = false;
    input = {
      keyboard.numlockOnStartup = "on";
      mice = [
        {
          enable = true;
          name = "PixArt Microsoft USB Optical Mouse";
          productId = "00cb";
          vendorId = "045e";

          leftHanded = true;
        }
      ];
      touchpads = [
        {
          enable = true;
          name = "ELAN0712:00 04F3:30FD Touchpad";
          productId = "30fd";
          vendorId = "04f3";

          disableWhileTyping = false;
          naturalScroll = true;
        }
      ];
    };
    panels = [
      {
        widgets = [
          {
            kickoff = {
              icon = "nix-snowflake";
              sortAlphabetically = true;
              sidebarPosition = "right";
              favoritesDisplayMode = "list";
              showButtonsFor = "powerAndSession";
              showActionButtonCaptions = false;
              settings.General.switchCategoryOnHover = true;
            };
          }
          {
            iconTasks = {
              behavior.grouping.method = "none";
              settings.General.wheelEnabled = "AllTask";
              launchers = [ ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.notifications"
          "org.kde.plasma.battery"
          "org.kde.plasma.devicenotifier"
          "org.kde.plasma.clipboard"
          "org.kde.plasma.volume"
          "org.kde.plasma.brightness"
          "org.kde.plasma.bluetooth"
          "org.kde.plasma.networkmanagement"
          {
            digitalClock = {
              date.format.custom = "ddd, yyyy-MM-dd";
              time.showSeconds = "always";
            };
          }
        ];
      }
    ];
    kscreenlocker = {
      appearance.wallpaperPictureOfTheDay.provider = "bing";
      autoLock = true;
      timeout = 2;
    };
    workspace = {
      colorScheme = "BreezeDark";
      cursor = {
        size = 24;
        theme = "Bibata-Modern-Classic";
        cursorFeedback = "None";
      };
      splashScreen.theme = "None";
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
    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 20;
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "nothing";
        turnOffDisplay.idleTimeout = 30;
        turnOffDisplay.idleTimeoutWhenLocked = "immediately";
        whenLaptopLidClosed = "sleep";
      };
      battery = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 20;
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "nothing";
        turnOffDisplay.idleTimeout = 30;
        turnOffDisplay.idleTimeoutWhenLocked = "immediately";
        whenLaptopLidClosed = "sleep";
      };
      lowBattery = {
        autoSuspend.action = "shutDown";
        autoSuspend.idleTimeout = 60;
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 20;
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "nothing";
        turnOffDisplay.idleTimeout = 30;
        turnOffDisplay.idleTimeoutWhenLocked = "immediately";
        whenLaptopLidClosed = "shutDown";
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
      "services/code.desktop"._launch = [
        "Launch Mail"
        "Meta+A"
      ];
      "services/google-chrome.desktop"._launch = [
        "Home Page"
        "Meta+W"
      ];
      "services/net.nokyan.Resources.desktop"._launch = [
        "Search"
        "Meta+Z"
      ];
    };
    spectacle.shortcuts.captureRectangularRegion = "Meta+S";
  };
}
