# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  updates,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-edce8522-be8e-4801-b421-a3bcfd70427b".device = "/dev/disk/by-uuid/edce8522-be8e-4801-b421-a3bcfd70427b";
  networking.hostName = "nitro"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Araguaina";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };
    desktopManager.plasma6.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "br";

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.edmundo = {
    isNormalUser = true;
    description = "Edmundo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.audacity
    pkgs.calibre
    pkgs.chromium
    pkgs.corepack_20
    pkgs.distrobox
    pkgs.firefox
    pkgs.google-chrome
    pkgs.gparted
    pkgs.hwinfo
    pkgs.inkscape
    pkgs.kdePackages.isoimagewriter
    pkgs.kdePackages.kdenlive
    pkgs.kdePackages.ktorrent
    pkgs.lutris
    pkgs.mpv
    pkgs.nixfmt-rfc-style
    pkgs.nodejs_20
    pkgs.obs-studio
    pkgs.postman
    pkgs.slack
    pkgs.steam
    pkgs.sublime-merge
    pkgs.telegram-desktop
    pkgs.ventoy
    pkgs.vscode
    pkgs.waydroid
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  virtualisation = {
    containers.enable = true;
    podman.enable = true;
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  programs.git = {
    enable = true;
    config = {
      user.name = "Edmundo";
      user.email = "manyymoore@gmail.com";
      init.defaultBranch = "main";
    };
  };

  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "schedutil";
          turbo = "never";
        };
        battery = {
          governor = "powersave";
          turbo = "never";
        };
      };
    };
  };

  hardware.bluetooth.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:1:00:0";
        amdgpuBusId = "PCI:5:00:0";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 21 ];
  services.vsftpd = {
    enable = true;
    localUsers = true;
    writeEnable = true;
  };

  services.earlyoom.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
