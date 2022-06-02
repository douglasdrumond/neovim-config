-- Inspired by
-- https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f

require("plugins")
require("options")
require("mappings")

-- Further settings

-- Make Windows clipboard detect text copied from Neovim
local command = "uname -r"
local handle = io.popen(command)
local os_name = handle:read("*a")
handle:close()
if string.match(os_name, "microsoft") then
  vim.cmd([[
        augroup Yank
            autocmd!
            autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
        augroup END
    ]])
end
