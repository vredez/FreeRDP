{
  description = "FreeRDP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    freerdp-vredez = pkgs.freerdp.overrideAttrs (old: {
      version = "vredez";
      src = ./.;
      buildInputs =
        old.buildInputs
        ++ (with pkgs; [
          sdl3
          sdl3-image
          sdl3-ttf
        ]);
    });
  in {
    packages.${system} = {
      inherit freerdp-vredez;
      default = freerdp-vredez;
    };
    devShells.${system}.default = let
      inherit (freerdp-vredez) name;
    in
      pkgs.mkShell {
        inherit name;
        inherit (freerdp-vredez) buildInputs;
        nativeBuildInputs = freerdp-vredez.nativeBuildInputs ++ (with pkgs; [clang-tools]);
        shellHook = ''
          export NIX_SHELL=${name}
        '';
      };
  };
}
