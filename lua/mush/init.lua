local M = {}

local defaults = {
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = false },
  },
}

local config = vim.deepcopy(defaults)

local function set_terminal_colors(palette)
  local terminal = {
    palette.bg,
    palette.red,
    palette.green,
    palette.yellow,
    palette.blue,
    palette.purple,
    palette.cyan,
    palette.fg,
    palette.muted,
    palette.bright_red,
    palette.bright_green,
    palette.bright_yellow,
    palette.bright_blue,
    palette.bright_purple,
    palette.bright_cyan,
    palette.bright_fg,
  }

  for index, color in ipairs(terminal) do
    vim.g["terminal_color_" .. (index - 1)] = color.gui
  end
end

function M.setup(opts)
  vim.validate("opts", opts, "table", true)
  config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end

function M.load(variant)
  vim.validate("variant", variant, function(value)
    return value == "dark" or value == "light"
  end, "dark or light")

  local palette = require("mush.palette").get(variant)

  vim.cmd.highlight("clear")
  require("mush.groups.core").apply(palette, config)
  require("mush.groups.syntax").apply(palette, config)
  require("mush.groups.treesitter").apply(palette)
  require("mush.groups.lsp").apply(palette)
  require("mush.groups.rust").apply(palette)
  require("mush.groups.plugins").apply(palette)

  if config.terminal_colors then
    set_terminal_colors(palette)
  end

  vim.g.colors_name = "mush-" .. variant
end

return M
