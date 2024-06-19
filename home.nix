{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ahi";
  home.homeDirectory = "/home/ahi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # pkgs.hello

    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # NOTE: nix ignores all files that are not in a git repo, if a git repo is present. make to to `git add` any new files
  # source: https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#managing-the-configuration-with-git
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    ".bashrc".source = config/bash/bashrc;
    ".gitconfig".source = config/git/gitconfig;
    "./.config/fish/config.fish".source = config/fish/config.fish;
    "./.bin/rebuild".source = config/scripts/rebuild;
    "./.bin/update".source = config/scripts/update;
    "./.bin/clean".source = config/scripts/clean;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ahi/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    home-manager.enable = true; # Let Home Manager install and manage itself.
    gh.enable = true;
    lazygit.enable = true;

    neovim.enable = true;
    neovim.plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      coc-rust-analyzer
    ];
  };

  # programs.powerline-go.enable = true;
}
