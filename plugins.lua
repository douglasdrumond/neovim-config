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
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = get_setup("tree"),
    })

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

