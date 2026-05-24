{ ... }:

{
  programs.nixvim = {
    enable = true;

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
        transparent = true;
      };
    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      termguicolors = true;
      clipboard = "unnamedplus";
    };

    globals.mapleader = " ";

    keymaps = [
      {
        key = "<leader>e";
        action = "<cmd>NvimTreeFocus<CR>";
      }
      {
        key = "<leader>t";
        action = "<cmd>NvimTreeToggle<CR>";
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
      }
      {
        key = "<leader>fo";
        action = "<cmd>lua require('conform').format()<CR>";
      }
    ];

    diagnostic.settings = {
      virtual_text = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
      signs = true;
    };

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      treesitter = {
        enable = true;
        settings.ensure_installed = "all";
      };
      web-devicons.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            json = [ "prettier" ];
            css = [ "prettier" ];
            html = [ "prettier" ];
            rust = [ "rustfmt" ];
          };
        };
      };

      nvim-tree = {
        enable = true;
        settings.renderer.indent_markers.enable = true;
        settings.view = {
          width = 30;
          side = "left";
        };
        settings.ui.confirm.remove = false;
        settings.view.float.enable = false;
      };

      bufferline = {
        enable = true;
        settings.options = {

          offsets = [
            {
              filetype = "NvimTree";
              text = "Files";
              highlight = "Directory";
              separator = false;
              padding = 1;
            }
          ];
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true; # nixvim convenience flag
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          clangd = {
            enable = true;
            cmd = [
              "clangd"
              "--query-driver=**/g++"
            ];
          };
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };

    };

    extraConfigLua = ''
      local function fix_nvimtree_transparency()
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
        vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "none", fg = "#16161e" })
        vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#16161e" })
        vim.api.nvim_set_hl(0, "VertSplit", { bg = "none", fg = "#16161e" })
        vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none" })
        vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "none" })
        vim.api.nvim_set_hl(0, "BufferLineOffset", { bg = "none", fg = "none" })
      end

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        callback = fix_nvimtree_transparency,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "NvimTree",
        callback = fix_nvimtree_transparency,
      })
    '';

  };

}
