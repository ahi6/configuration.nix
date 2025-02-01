{
  pkgs,
  lib,
  ...
}: {
  services.jack = {
    jackd.enable = true;
    #    jackd.extraOptions = ["-dalsa" "--device" "hw:PCH,0"];
    # support ALSA only programs via ALSA JACK PCM plugin
    alsa.enable = true;
    # support ALSA only programs via loopback device (supports programs like Steam)
    loopback = {
      enable = false;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
      #dmixConfig = ''
      #  period_size 2048
      #'';
    };
  };
  users.extraUsers.ahi.extraGroups = ["jackaudio"];
}
