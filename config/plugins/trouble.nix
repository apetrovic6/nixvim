{ config, pkgs, ... }:

{
  plugins.trouble = {
    enable = true;

    settings = {
      position = "bottom";
      width = 50;
    };
  };

  keymaps = [
    {
      action = "<cmd>Trouble diagnostics toggle<cr>";
      key = "<leader>tt";
      options.desc = "Diagnostics";
    }
    {
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      key = "<leader>tT";
      options.desc = "Buffer Diagnostics";
    }
    {
      action = "<cmd>Trouble symbols toggle focus=false<cr>";
      key = "<leader>ts";
      options.desc = "Symbols";
    }
    {
      action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
      key = "<leader>tr";
      options.desc = "Lsp References";
    }
    {
      action = "<cmd>Trouble loclist toggle<cr>";
      key = "<leader>tl";
      options.desc = "Loc List";
    }
    {
      action = "<cmd>Trouble qflist toggle<cr>";
      key = "<leader>tq";
      options.desc = "Quick Fix";
    }
  ];
}
