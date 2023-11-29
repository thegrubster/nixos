{ ... }:
{
  imports =
    [
      <home-manager/nixos>
      /etc/nixos/hosts/desktop/hardware-configuration.nix
      /etc/nixos/hosts/desktop/system/system.nix
      /etc/nixos/shared/system/system.nix
      /etc/nixos/shared/base-config.nix
    ];

  fileSystems."/mnt/external" = {
    device = "/dev/disk/by-uuid/60de9566-d001-4586-a3fd-0604a61f428d";
    fsType = "ext4";
  };

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
}
