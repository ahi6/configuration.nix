{pkgs, ...}: {
  users.users.ahi.packages = with pkgs; [
    zed-editor-fhs
    rust-analyzer
    nixd
    nil
  ];
}
