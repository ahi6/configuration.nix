{pkgs, ...}: {
  users.users.ahi.packages = with pkgs; [
    zed-editor-fhs
    zed-discord-presence
    #    rust-analyzer
    #    nixd
    #    nil
  ];
}
