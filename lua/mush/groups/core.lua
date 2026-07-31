local M = {}

local function highlight(palette, spec)
  local result = vim.deepcopy(spec)

  for _, field in ipairs({ "fg", "bg", "sp" }) do
    local role = result[field]
    if type(role) == "string" then
      result[field] = palette[role].gui
      if field == "fg" then
        result.ctermfg = palette[role].cterm
      elseif field == "bg" then
        result.ctermbg = palette[role].cterm
      end
    end
  end

  return result
end

function M.apply(palette, config)
  local background = config.transparent and nil or "bg"
  local groups = {
    Normal = { fg = "fg", bg = background },
    NormalNC = { fg = "fg", bg = background },
    NormalFloat = { fg = "fg", bg = "bg_elevated" },
    FloatBorder = { fg = "subtle", bg = "bg_elevated" },
    EndOfBuffer = { fg = config.transparent and "bg" or "subtle", bg = background },
    SignColumn = { fg = "muted", bg = background },
  }

  for name, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, name, highlight(palette, spec))
  end
end

return M
