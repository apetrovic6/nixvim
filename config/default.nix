{ pkgs, ... }:

{
  imports = [
    ./dashboard.nix
    ./plugins/toggleterm.nix
    ./plugins/telescope.nix
    ./plugins/harpoon.nix
    ./plugins/which-key.nix
    ./plugins/lsp.nix
    ./plugins/nvim-tree.nix
    ./plugins/cmp.nix
    ./plugins/trouble.nix
    ./plugins/noice.nix
    ./plugins/todo-comments.nix
    ./plugins/lazygit.nix
    ./plugins/lint.nix
    ./plugins/spectre.nix
    ./plugins/bufferline.nix
    ./plugins/cmp.nix
    ./plugins/dap.nix
    ./plugins/lspsaga.nix
    ./plugins/none-ls.nix
  ];

  globals.mapleader = " ";

  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    termguicolors = true;
    fillchars = "eob: ,fold: ,vert:│";
    autoindent = true;
    expandtab = true;
    smartcase = true;
    smartindent = true;
    wrap = false;
    swapfile = false;
  };

  plugins = {
    persistence.enable = true;
    lsp-format.enable = true;
    lualine.enable = true;
    oil.enable = true;
    gitgutter.enable = true;
    treesitter-context.enable = true;

    ###    multicursors.enable = true;

    fzf-lua.enable = true;
    luasnip.enable = true;
    nix.enable = true;
    nix-develop.enable = true;
    notify.enable = true;
    # qmk.enable = true;
    indent-o-matic.enable = true;
    indent-blankline = {
      enable = true;

      settings = {
        debounce = 1000;
        scope = {
          enabled = true;
          show_start = false;
          injected_languages = true;
        };
      };
    };
  };

  plugins.mini = {
    enable = true;
    modules = {
      ai = {
        n_lines = 50;
        search_method = "cover_or_next";
      };
      surround = { };
    };
  };
  plugins.lspkind = {
    enable = true;
    cmp.enable = true;
  };

  plugins.nvim-colorizer.enable = true;

  plugins.leap = { enable = true; };

  plugins.dressing.enable = true;

  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;
    indent = true;
    settings = {
      highlight.enable = true;
      ensure_installed = [
        "eex"
        "elixir"
        "erlang"
        "heex"
        "iex"
        "html"
        "surface"
        "json"
        "jsdoc"
        "angular"
        "bash"
        "asm"
        "c"
        "cpp"
        "css"
        "csv"
        "dart"
        "dockerfile"
        "doxygen"
        "go"
        "gomod"
        "gosum"
        "graphql"
        "javascript"
        "lua"
        "luadoc"
        "make"
        "markdown"
        "ocaml"
        "proto"
        "python"
        "regex"
        "rust"
        "sql"
        "typescript"
        "udev"
        "yaml"
        "xml"
      ];
      auto_install = true;
    };

  };

  keymaps = [

    {
      action = "<cmd>wincmd j<cr>";
      key = "<c-e>";
      options.desc = "Focus Down Split";
    }

    {
      action = "<cmd>wincmd k<cr>";
      key = "<c-i>";
      options.desc = "Focus Up Split";
    }

    {
      action = "<cmd>wincmd l<cr>";
      key = "<c-o>";
      options.desc = "Focus Right Split";
    }

    {
      action = "<cmd>wincmd h<cr>";
      key = "<c-n>";
      options.desc = "Focus Left Split";
    }

    {
      action = "<cmd>only<cr>";
      key = "<leader>wo";
      options.desc = "Close all other windows";
    }

    {
      action = "<cmd>split<cr>";
      key = "<leader>wh";
      options.desc = "Horizontal Split";
    }

    {
      action = "<cmd>vs<cr>";
      key = "<leader>wv";
      options.desc = "Vertical Split";
    }
  ];

  colorschemes.catppuccin.enable = true;

  clipboard.providers.wl-copy.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    hardtime-nvim
    flutter-tools-nvim
    roslyn-nvim
    rzls
    # nvim-treesitter.withAllGrammars
    # elixir-tools-nvim
  ];

  extraConfigLua = # lua
    ''
        require("flutter-tools").setup{
      debugger = { -- integrate with nvim dap + install dart code debugger
         enabled = true,
         run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
       },
        }
           require('telescope').load_extension('flutter')
           require("hardtime").setup({
             disable_mouse = false,

             disabled_keys =  {
               ["<Up>"] =  {},
               ["<Down>"] = {},
               ["<Right>"] ={},
               ["<Left>"] = {},
             },

             restricted_keys =  {
               ["<Up>"] =  {"n", "x"},
               ["<Down>"] = {"n", "x"},
               ["<Right>"] ={"n", "x"},
               ["<Left>"] = {"n", "x"},
             },

           })

           local on_attach = function(_, bufnr)
           end

           local capabilities = vim.lsp.protocol.make_client_capabilities()
           capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

           require("roslyn").setup({
               dotnet_cmd = "dotnet", -- this is the default
               roslyn_version = "4.8.0-3.23475.7", -- this is the default
               on_attach = on_attach, -- required
               capabilities = capabilities, -- required
           })

          require("rzls").setup({
               on_attach = on_attach, 
               capabilities = capabilities, 
               path = "${pkgs.vimPlugins.rzls}"
           })



    '';
}
