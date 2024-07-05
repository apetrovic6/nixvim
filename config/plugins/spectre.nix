{ config, pkgs, ... }:

{
  plugins.spectre.enable = false;

  keymaps = [
    {
      action = "<cmd>lua require('spectre').toggle()<cr>";
      key = "<leader>fss";
      options.desc = "Toggle Spectre";
    }
    {
      action =
        "<cmd>lua require('spectre').open_visual({select_word=true})<cr>";
      key = "<leader>fsw";
      options.desc = "Search current word";
    }
    {
      action = "<cmd>lua require('spectre').open_visual()<cr>";
      key = "<leader>fsw";
      options.desc = "Search current word";
    }
    {
      action =
        "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>";
      key = "<leader>fsf";
      options.desc = "Search on current file";
    }

  ];
}
