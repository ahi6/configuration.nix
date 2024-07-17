# This is my personal NixOS configuration repository
I aim to keep my configuration simple and minimal. I use a mostly vanilla GNOME Desktop without anything particularly exciting. 
These are intended to be used only for my main computer and aren't designed suit other people's needs out of the box, but feel free to copy and paste snippets to your own config or use it as a base.  

If you are considering NixOS yourself, keep in mind that managing nix configs is largely a Sisyphean task which is not worth the effort for most users. That being said, *one must imagine Sysiphus happy...*

![NixOS Screenshot](https://github.com/ahi6/configuration.nix/assets/60984726/48701aab-0120-4c99-a0f4-7c0b18e62e57)


## Directory structure
```sh
nixos
├── README.md
├── config # dotfiles
│   ├── bash
│   │   └── bashrc
│   ├── fish
│   │   └── config.fish
│   ├── git
│   │   └── gitconfig
│   └── scripts  # scripts that make managing my OS with nix more convenient
│       ├── clean   # nix-collect-garbage wrapper
│       ├── rebuild # nixos-rebuild       wrapper
│       └── update  # nix flake update    wrapper
├── flake.lock
├── flake.nix
├── home.nix # home manager config, literally just moves dotfiles from /config to the correct folder
├── hosts
│   └── ahinix
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules # modules for programs that require more than just adding to systemPackages
│   ├── davinci.nix
│   ├── no-middle-click-paste.nix
│   └── warp.nix
└── overlays
    └── pkgs
        └── gnome-backgrounds # adds a custom GNOME wallpaper with light and dark mode variations
            ├── default.nix
            ├── wallhaven-1kqv13.png # https://wallhaven.cc/w/1kqv13
            └── wallhaven-m9wyyy.png # https://wallhaven.cc/w/m9wyyy
```

---


[![Put everything in configuration.nix](https://github.com/user-attachments/assets/0f49f4d6-befe-4462-ac61-aef66e8ffd4d)(source)](https://www.tumblr.com/linux-real/755298701751304192)
