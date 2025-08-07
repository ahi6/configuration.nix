{pkgs}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "discord-presence-lsp";
  version = "8fbf6c68527de3ca54809967e184f1f314034dc9";
  cargoHash = "sha256-JLNCEeo9fKeV4vTtPs+Yj2wRO1RKP2fuetrPlXcPBjA=";

  src = pkgs.fetchFromGitHub {
    owner = "xhyrom";
    repo = "zed-discord-presence";
    rev = version;
    hash = "sha256-RmpY0xkJYNDYn6SWNdKGpPetmBxf2/xY25FLeJqf0Po=";
  };

  cargoBuildFlags = "--package discord-presence-lsp";
}
