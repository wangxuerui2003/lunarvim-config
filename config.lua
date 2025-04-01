-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"

lvim.format_on_save = {
  enabled = true,
}

-- clipboard
vim.opt.clipboard = 'unnamedplus'

lvim.plugins = {
  -- multi line
  { "mg979/vim-visual-multi", branch = "master" },

  -- venv selector
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    opts = {
      auto_refresh = true,
      search_workspace = true,
      name = { "*venv", ".*venv" },
      stay_on_this_version = true,
    },
  },

  -- session management
  { "tpope/vim-obsession",    branch = "master" },

  -- VimTex (LaTex)
  { "lervag/vimtex",          branch = "master" },

  -- git blame
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 300,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      }
    end,
  },
}

-- Auto-run VenvSelectCached when opening a Python file
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function()
    vim.defer_fn(function()
      vim.cmd("VenvSelectCached")
    end, 1000) -- Delay 1000ms to avoid load venv faster than LSP
  end,
})

-- Virtual Environment selector
lvim.builtin.which_key.mappings["v"] = {
  name = "VirtualEnv",
  p = { "<cmd>VenvSelect<cr>", "Pick VirtualEnv" },
  c = { "<cmd>VenvSelectCached<cr>", "Use Cached VirtualEnv" },
}

-- vimtex settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexrun'
