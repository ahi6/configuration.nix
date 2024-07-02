# HOW TO ADAPT THIS TO A DIFFERENT CONFIGURATION
# 1. Find the mouse you want to disable middle-click-paste for
#   1.1 Try running `evsieve --input ${mousePath} grab --hook btn:middle exec-shell="wl-copy -pc && xsel -nc" --output` manually
# 2. Change my username in "users.users.ahi" to your username (change the "ahi" part)
# 3. Reboot
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    evsieve # intercept middle click
    xsel # clear X11 clipboard
    wl-clipboard # clear Wayland clipboard
  ];

  systemd.user.services.no-middle-click-paste = let
    mousePath = "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:1:1.1-event-mouse"; # you have to find this on your own in /dev/input/by-path via experimentation
  in {
    enable = true;
    description = "Clear primary clipboard on middle click";
    serviceConfig.PassEnvironment = "DISPLAY";
    serviceConfig.Type = "idle"; # 5s delay, probably unnecessary 
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    path = with pkgs; [
      evsieve 
      xsel 
      wl-clipboard 
    ];
    script = ''
      evsieve --input ${mousePath} grab --hook btn:middle exec-shell="wl-copy -pc && xsel -nc" --output
    '';
  };

  users.users.ahi = {
    # adding to a group requires reboot
    extraGroups = ["input"]; # /dev/input devices belong to this group, sometimes they don't, you can check with `stat -c %G /dev/input/event0`
  };
}
