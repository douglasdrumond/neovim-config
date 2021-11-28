-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_setup(name)
  return string.format('require("setup/%s")', name)
end

-- Auto install plugins on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Auto install Packer if not available
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end
vim.api.nvim_command("packadd packer.nvim")

return require("packer").startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Add other packages
    use({ "nathom/filetype.nvim", config = get_setup("filetype") })
    use({ "EdenEast/nightfox.nvim", config = get_setup("nightfox") })
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufReadPre",
      config = get_setup("colorizer"),
    })

    -- for lualine
    use({ "kyazdani42/nvim-web-devicons" })
    use({
      "nvim-lualine/lualine.nvim",
      config = get_setup("lualine"),
      event = "VimEnter",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- Post-install/update hook with neovim command
    use({
      "nvim-treesitter/nvim-treesitter",
      config = get_setup("treesitter"),
      run = ":TSUpdate",
    })

    -- File explorer
    use({
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = get_setup("tree"),
    })

    -- Super fast git decorations
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      event = "BufReadPre",
      config = get_setup("gitsigns"),
    })

    -- Rainbow parentheses
    use("p00f/nvim-ts-rainbow")

    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more
    use({ "jose-elias-alvarez/null-ls.nvim", config = get_setup("null-ls") })
    -- LSP Configuration
    use({ "neovim/nvim-lspconfig", config = get_setup("lsp") })

    use({ "onsails/lspkind-nvim", requires = { { "famiu/bufdelete.nvim" } } })

    use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-vsnip" },
        { "f3fora/cmp-spell", { "hrsh7th/cmp-calc" }, { "hrsh7th/cmp-emoji" } },
      },
      config = get_setup("cmp"),
    })

    -- Commenting
    use({
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc" },
      config = get_setup("comment"),
    })

    -- Extendable fuzzy finder
    use({
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
      },
      config = get_setup("telescope"),
    })

    -- Neovim plugin to stabilize buffer content on window open/close events.
    use({ "luukvbaal/stabilize.nvim", config = get_setup("stabilize") })

    use({ "wellle/targets.vim" })
    use({
      "phaazon/hop.nvim",
      event = "BufReadPre",
      config = get_setup("hop"),
    })

    use({
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline" },
      config = get_setup("outline"),
    })

    use({
      "winston0410/range-highlight.nvim",
      requires = {
	{ "winston0410/cmd-parser.nvim" },
      },
    })

    use({ "filipdutescu/renamer.nvim", config = get_setup("renamer") })

    -- End (Add other packages)

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
