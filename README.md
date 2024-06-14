# This is my personal NixOS configuration repository
I aim to keep my configuration simple and minimal. I use a mostly vanilla GNOME Desktop without anything particularly exciting. 
These are intended to be used only for my main computer and aren't designed suit other people's needs out of the box, but feel free to copy and paste snippets to your own config or use it as a base.  

![NixOS Screenshot](https://github.com/ahi6/configuration.nix/assets/60984726/48701aab-0120-4c99-a0f4-7c0b18e62e57)


## Directory structure
```sh
nixos
├── home.nix # home manager config, literally just moves dotfiles from /config to the correct folder
├── config # dotfiles
│   ├── fish
│   │   └── config.fish
│   ├── bash
│   │   └── bashrc
│   ├── scripts # scripts that make managing my OS with nix more convenient
│   │   ├── clean   # nix-collect-garbage wrapper
│   │   ├── rebuild # nixos-rebuild       wrapper
│   │   └── update  # nix flake update    wrapper
│   └── git
│       └── gitconfig
├── README.md
├── flake.nix
├── flake.lock
├── modules # modules for programs that require more than just adding to systemPackages
│   ├── warp.nix
│   └── davinci.nix
└── hosts  
    └── ahinix
        ├── configuration.nix # this is the main configuration file, where most installed programs are listed
        └── hardware-configuration.nix
```


