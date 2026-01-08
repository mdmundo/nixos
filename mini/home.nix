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
    overrideConfig = true;
    session.general.askForConfirmationOnLogout = false;
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
        widgets = [
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake";
            };
          }
          {
            iconTasks = {
              behavior = {
                grouping.method = "none";
                wheel.switchBetweenTasks = true;
              };
              launchers = [
                "applications:google-chrome.desktop"
                "applications:code.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          {
            digitalClock.time.showSeconds = "always";
          }
          "org.kde.plasma.showdesktop"
        ];
      }
      # Application name, Global menu and Song information and playback controls at the top
      {
        location = "top";
        height = 26;
        widgets = [
          {
            applicationTitleBar = {
              behavior = {
                activeTaskSource = "activeTask";
              };
              layout = {
                elements = [ "windowTitle" ];
                horizontalAlignment = "left";
                showDisabledElements = "deactivated";
                verticalAlignment = "center";
              };
              overrideForMaximized.enable = false;
              titleReplacements = [
                {
                  type = "regexp";
                  originalTitle = "^Brave Web Browser$";
                  newTitle = "Brave";
                }
                {
                  type = "regexp";
                  originalTitle = ''\\bDolphin\\b'';
                  newTitle = "File manager";
                }
              ];
              windowTitle = {
                font = {
                  bold = false;
                  fit = "fixedSize";
                  size = 12;
                };
                hideEmptyTitle = true;
                margins = {
                  bottom = 0;
                  left = 10;
                  right = 5;
                  top = 0;
                };
                source = "appName";
              };
            };
          }
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          {
            plasmusicToolbar = {
              panelIcon = {
                albumCover = {
                  useAsIcon = false;
                  radius = 8;
                };
                icon = "view-media-track";
              };
              playbackSource = "auto";
              musicControls.showPlaybackControls = true;
              songText = {
                displayInSeparateLines = true;
                maximumWidth = 640;
                scrolling = {
                  behavior = "alwaysScroll";
                  speed = 3;
                };
              };
            };
          }
        ];
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
    };
    spectacle.shortcuts.captureRectangularRegion = "Meta+S";
  };
}
