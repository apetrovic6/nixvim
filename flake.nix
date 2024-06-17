{
  description = "NixVim flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      #      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    plugin-rzls = {
      url = "github:tris203/rzls.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixvim, flake-parts, plugin-rzls, ... }@inputs:
    let
      config = import ./config;
      overlay = final: prev: {
        vimPlugins = prev.vimPlugins // {
          rzls = prev.vimUtils.buildVimPlugin {
            name = "rzls";
            src = plugin-rzls;
          };
        };
      };
    in flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { pkgs, system, ... }:
        let
          nixpkgsWithOverlay = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };

          nixvimLib = nixvim.lib.${system};
          nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
            pkgs = nixpkgsWithOverlay;
            module = config;
          };
        in {
          checks = {
            default = nixvimLib.check.mkTestDerivationFromNvim {
              inherit nvim;
              name = "A nixvim configuration";
            };
          };

          packages = { default = nvim; };

          devShells.default = nixpkgsWithOverlay.mkShellNoCC {
            shellHook = ''
              echo Welcome to a Neovim dev environment powered by Nixvim -- https://github.com/nix-community/nixvim
              PS1="Nixvim: \\w \$ "
              alias vim='nvim'
            '';
            packages = [ nvim ];
          };
        };
    };
}
