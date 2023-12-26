{
  description = "Nix flake for Lua including a language server and formatter (stylua)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [
          (self: super: {
            stylua = super.stylua.override {
              features = ["lua54"];
            };
          })
        ];
        pkgs = import nixpkgs {
          inherit system;
		  overlays = overlays;
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            alejandra
            coreutils
			graphviz
            moreutils
            jq
            lua5_4
            luajit
			nodePackages.prettier
            stylua
            lua-language-server
            tokei
          ];
        };
      }
    );
}
