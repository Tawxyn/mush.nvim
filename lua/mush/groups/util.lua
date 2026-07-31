local M = {}

local function resolve(palette, spec)
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

function M.apply(palette, groups)
  for name, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, name, resolve(palette, spec))
  end
end

return M
