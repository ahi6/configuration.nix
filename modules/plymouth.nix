{
  pkgs,
  ...
}: {
boot = {

    plymouth = {
      enable = true;
      theme = "blåhaj";
      themePackages = with pkgs; [
        plymouth-blahaj-theme      ];
    };

    # Enable "Silent Boot"
    #consoleLogLevel = 0;
    #initrd.verbose = false;
    #kernelParams = [
    #  "quiet"
    #  "splash"
    #  "boot.shell_on_fail"
    #  "loglevel=3"
    #  "rd.systemd.show_status=false"
    #  "rd.udev.log_level=3"
    #  "udev.log_priority=3"
    #];

    # Not plymouth related, but let's set the 
    # GRUB selection screen timeout to 1s
    loader.timeout = 1;
  };

}

