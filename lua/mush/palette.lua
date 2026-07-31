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
    bg = color("#f8faf7", 255),
    bg_elevated = color("#f0f2ef", 254),
    bg_highlight = color("#dfe3df", 253),
    bg_visual = color("#ccd2cc", 251),
    fg = color("#101310", 233),
    bright_fg = color("#000000", 16),
    muted = color("#4b574e", 240),
    subtle = color("#707a72", 243),
    red = color("#c0002f", 160),
    bright_red = color("#99001f", 88),
    orange = color("#a83b00", 130),
    yellow = color("#745800", 58),
    bright_yellow = color("#5c4500", 58),
    green = color("#00733f", 29),
    bright_green = color("#005a31", 22),
    cyan = color("#006a78", 24),
    bright_cyan = color("#00535f", 23),
    blue = color("#005cc5", 26),
    bright_blue = color("#00499f", 25),
    purple = color("#7526a8", 55),
    bright_purple = color("#59168e", 54),
    pink = color("#aa005f", 125),
  },
}

function M.get(variant)
  return palettes[variant]
end

return M
