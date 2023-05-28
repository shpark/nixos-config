{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # boot.kernelPackages = let
  #   linux_custom_pkg = { fetchurl, buildLinux, ... }@args:

  #     buildLinux (args // rec {
  #       version = "6.4.0-rc2";
  #       modDirVersion = version;

  #       src = fetchurl {
  #         url = "https://github.com/shpark/linux/archive/refs/tags/v6.4-rc2-fix.tar.gz";
  #         sha256 = "1fz41p7krwsfvfja60wrlg9pmdiczgqklvfri5a3nk0pvg61gryz";
  #       };

  #       kernelPatches = [];

  #       extraConfig = "";

  #       extraMeta.branch = "6.4.0-rc2";
  #     } // (args.argsOverride or {}));

  #   linux_custom = pkgs.callPackage linux_custom_pkg{};
  # in
  #   pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_custom);

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
