-- Nightfox config
local nightfox = require("nightfox")
nightfox.setup({
  fox = "nordfox",
  transparent = true,
  alt_nc = true,
  visual = true,
  search = true,
  styles = {
    comments = "italic",
    keywords = "bold",
    functions = "italic,bold",
  },
})
nightfox.load()
