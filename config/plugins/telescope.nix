{ config, pkgs, ... }:

{
   plugins = { telescope.enable = true; }; 

keymaps = [
    {
      action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
      key = "<leader>fg";
      options.desc = "Live Grep";
    }

    {
      action = "<cmd>lua require('telescope.builtin').find_files()<cr>";
      key = "<leader>ff";
      options.desc = "Find files";
    }

    {
      action = "<cmd>lua require('telescope.builtin').buffers()<cr>";
      key = "<leader>fb";
      options.desc = "Find Buffers";
    }

    {
      action = "<cmd>lua require('telescope.builtin').help_tags()<cr>";
      key = "<leader>fh";
      options.desc = "Find Help Tags";
    }

    {
      action = "<cmd>Telescope flutter commands<cr>";
      key = "<leader>ut";
      options.desc = "Flutter Commands";
    }

  ];
}
