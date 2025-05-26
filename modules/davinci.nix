# NOTE: DaVinci Resolve (Free edition) doesn't support support the H.264 codec on Linux
# Most videos require being manually processed through ffmpeg first
# example: ffmpeg -i input.mp4 -c:v dnxhd -b:v 120M -vf "scale=1920:1080,fps=24" -c:a pcm_s16le output.mov
# DaVinci Resolve doesn't create a desktop shortcut, run it via `davinci-resolve` in the terminal in the home directory
{
  pkgs,
  lib,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
    ];
  };

  users.users.ahi = {
    packages = with pkgs; [
      davinci-resolve
    ];
  };
}
