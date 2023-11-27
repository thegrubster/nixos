{ pkgs, ... }:
{
  imports =
    [
      <home-manager/nixos>
      /etc/nixos/hosts/desktop/hardware-configuration.nix
      /etc/nixos/hosts/desktop/system/system.nix

      /etc/nixos/system/display.nix
      /etc/nixos/system/docker.nix
      /etc/nixos/system/fonts.nix
      /etc/nixos/system/boot.nix
      /etc/nixos/system/network.nix
      /etc/nixos/system/audio.nix
    ];

  fileSystems."/mnt/external" = {
    device = "/dev/disk/by-uuid/60de9566-d001-4586-a3fd-0604a61f428d";
    fsType = "ext4";
  };

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  users.users.krath = {
    isNormalUser = true;
    description = "krath";
    extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "video" ];
  };
  programs.zsh.enable = true;

  # home-manager setup
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.krath = {
      imports = [
        /etc/nixos/hosts/desktop/home/home.nix
        /etc/nixos/shared/home/home.nix
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
