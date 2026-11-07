local M = {}

local function color(gui, cterm)
  return { gui = gui, cterm = cterm }
end

local palettes = {
  dark = {
    bg = color("#0b0d0c", 233),
    bg_elevated = color("#151917", 234),
    bg_highlight = color("#202620", 235),
    bg_visual = color("#304238", 237),
    fg = color("#f4f7f2", 255),
    bright_fg = color("#ffffff", 15),
    muted = color("#9aa49b", 247),
    subtle = color("#657067", 243),
    red = color("#ff6b6b", 203),
    bright_red = color("#ff8787", 210),
    orange = color("#ff9f43", 215),
    yellow = color("#f4d35e", 221),
    bright_yellow = color("#ffe27a", 228),
    green = color("#72dd8a", 114),
    bright_green = color("#91eba2", 120),
    cyan = color("#54d6d6", 80),
    bright_cyan = color("#78e5e5", 123),
    blue = color("#75a7ff", 111),
    bright_blue = color("#94bbff", 153),
    purple = color("#c69cff", 183),
    bright_purple = color("#d5b5ff", 189),
    pink = color("#ff87c8", 211),
  },
  light = {
    bg = color("#fffefb", 231),
    bg_elevated = color("#f6f5f1", 255),
    bg_highlight = color("#e8e6e0", 254),
    bg_visual = color("#d8d7cf", 252),
    fg = color("#101310", 233),
    bright_fg = color("#000000", 16),
    muted = color("#4b574e", 240),
    subtle = color("#707a72", 243),
    red = color("#e0003e", 160),
    bright_red = color("#ea0042", 196),
    orange = color("#c94f00", 166),
    yellow = color("#926500", 94),
    bright_yellow = color("#9c6a00", 136),
    green = color("#00843d", 29),
    bright_green = color("#008847", 29),
    cyan = color("#00818e", 30),
    bright_cyan = color("#00828f", 30),
    blue = color("#0067e6", 26),
    bright_blue = color("#006ff0", 27),
    purple = color("#9330d7", 92),
    bright_purple = color("#a23ee2", 134),
    pink = color("#d0007c", 163),
  },
}

function M.get(variant)
  return palettes[variant]
end

return M
