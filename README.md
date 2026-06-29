# This is my personal NixOS configuration repository

Currently running on my Legion Go S connected to a dock.

## Host
- `ahinix`: Old laptop
- `tvo`: Legion Go S

## Directory structure
```sh
nixos
├── README.md
├── config # dotfiles
│   ├── ... 
│   └── scripts  # scripts that make managing my OS with nix more convenient
│       ├── clean   # nix-collect-garbage wrapper
│       ├── rebuild # nixos-rebuild       wrapper
│       └── update  # nix flake update    wrapper
├── flake.lock
├── flake.nix
├── home.nix # home manager config, literally just moves dotfiles from /config to the correct folder
├── hosts
│   ├── ahinix # old laptop
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── common
│   │   └── configuration.nix
│   └── tvo # Lenovo Legion Go S
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules # modules for programs that require more than just adding to systemPackages
│   ├── activate-linux.nix
│   ├── davinci.nix
│   ├── kde-connect.nix
│   ├── muni.nix # FI MUNI university-related packages
│   ├── no-middle-click-paste.nix
│   ├── plymouth.nix
│   ├── virtualbox.nix
│   ├── warp.nix
│   └── zed.nix
└── overlays
    └── pkgs
        └── gnome-backgrounds # adds a custom GNOME wallpaper with light and dark mode variations
            ├── default.nix
            ├── wallhaven-1kqv13.png # https://wallhaven.cc/w/1kqv13
            └── wallhaven-m9wyyy.png # https://wallhaven.cc/w/m9wyyy
```

---


[![Put everything in configuration.nix](https://github.com/user-attachments/assets/0f49f4d6-befe-4462-ac61-aef66e8ffd4d)(source)](https://www.tumblr.com/linux-real/755298701751304192)
