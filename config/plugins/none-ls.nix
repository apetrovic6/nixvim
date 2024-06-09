{ config, pkgs, ... }:

{
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    sources = {
      # diagnostics = { mypy.enable = true; };
      formatting = {
        nixfmt.enable = true;
        markdownlint.enable = true;
        shellharden.enable = true;
        clang_format.enable = true;
        prettierd.enable = true;
        stylua.enable = true;
        gofmt.enable = true;
        black.enable = true;
        csharpier.enable = true;
        dart_format.enable = true;
      };
    };
  };
}
