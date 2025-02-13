-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"

lvim.plugins = {
  { "mg979/vim-visual-multi", branch = "master" },
}

lvim.format_on_save = {
  enabled = true,
}

-- clipboard
vim.opt.clipboard = 'unnamedplus'

-- venv selector
lvim.plugins = {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    opts = {
      auto_refresh = true,
      search_workspace = true,
      name = { "*venv", ".*venv" },
      stay_on_this_version = true,
    },
  }
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

lvim.builtin.which_key.mappings["v"] = {
  name = "VirtualEnv",
  p = { "<cmd>VenvSelect<cr>", "Pick VirtualEnv" },
  c = { "<cmd>VenvSelectCached<cr>", "Use Cached VirtualEnv" },
}
