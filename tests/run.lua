local failures = 0
local completed = 0

local function test(name, callback)
  local ok, error_message = xpcall(callback, debug.traceback)
  if ok then
    completed = completed + 1
    print("ok - " .. name)
  else
    failures = failures + 1
    print("not ok - " .. name)
    print(error_message)
  end
end

local function get_hl(name, follow_links)
  return vim.api.nvim_get_hl(0, {
    name = name,
    link = not follow_links,
  })
end

local function assert_equal(actual, expected, message)
  assert(
    actual == expected,
    (message or "values differ") .. ": expected " .. vim.inspect(expected) .. ", got " .. vim.inspect(actual)
  )
end

local function assert_group(name)
  assert_equal(vim.fn.hlexists(name), 1, "missing highlight group " .. name)
end

test("both colorschemes load directly", function()
  vim.cmd.colorscheme("mush-dark")
  assert_equal(vim.g.colors_name, "mush-dark")

  vim.cmd.colorscheme("mush-light")
  assert_equal(vim.g.colors_name, "mush-light")
end)

test("representative highlight groups exist", function()
  vim.cmd.colorscheme("mush-dark")

  local groups = {
    "Normal",
    "NormalFloat",
    "PmenuSel",
    "Comment",
    "DiagnosticError",
    "DiagnosticUnderlineWarn",
    "DiffAdd",
    "@function",
    "@attribute.rust",
    "@lsp.type.interface.rust",
    "@lsp.mod.mutable.rust",
    "TelescopeMatching",
    "BlinkCmpLabelMatch",
    "CmpItemKindFunction",
    "GitSignsAdd",
    "NeoTreeRootName",
    "NvimTreeRootFolder",
    "WhichKeyGroup",
    "TroubleCount",
  }

  for _, name in ipairs(groups) do
    assert_group(name)
  end

  assert_equal(get_hl("@function", false).link, "Function")
  assert(get_hl("DiagnosticUnderlineWarn", true).undercurl)
end)

test("variant switching is repeatable", function()
  require("mush").setup()

  for _ = 1, 4 do
    vim.cmd.colorscheme("mush-dark")
    assert_equal(vim.g.colors_name, "mush-dark")
    assert_equal(get_hl("Normal", true).fg, tonumber("f4f7f2", 16))
    assert_equal(get_hl("Normal", true).bg, tonumber("0b0d0c", 16))
    assert_equal(get_hl("GitSignsAdd", true).fg, tonumber("72dd8a", 16))

    vim.cmd.colorscheme("mush-light")
    assert_equal(vim.g.colors_name, "mush-light")
    assert_equal(get_hl("Normal", true).fg, tonumber("101310", 16))
    assert_equal(get_hl("Normal", true).bg, tonumber("f8faf7", 16))
    assert_equal(get_hl("GitSignsAdd", true).fg, tonumber("146c38", 16))
  end
end)

test("loading preserves user options", function()
  vim.o.background = "light"
  vim.o.termguicolors = false
  vim.cmd.colorscheme("mush-dark")
  assert_equal(vim.o.background, "light")
  assert_equal(vim.o.termguicolors, false)

  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.cmd.colorscheme("mush-light")
  assert_equal(vim.o.background, "dark")
  assert_equal(vim.o.termguicolors, true)
end)

test("setup starts from defaults on every call", function()
  require("mush").setup({
    transparent = true,
    terminal_colors = false,
    styles = {
      comments = { italic = false },
      keywords = { bold = false },
      functions = { bold = true },
    },
  })
  vim.cmd.colorscheme("mush-dark")

  assert_equal(get_hl("Normal", true).bg, nil)
  assert(not get_hl("Comment", true).italic)
  assert(not get_hl("Keyword", true).bold)
  assert(get_hl("Function", true).bold)
  assert(get_hl("NormalFloat", true).bg)

  require("mush").setup({ transparent = false })
  vim.cmd.colorscheme("mush-light")

  assert_equal(get_hl("Normal", true).bg, tonumber("f8faf7", 16))
  assert(get_hl("Comment", true).italic)
  assert(get_hl("Keyword", true).bold)
  assert(not get_hl("Function", true).bold)
end)

test("terminal colors are opt-in configurable", function()
  vim.g.terminal_color_0 = "#123456"
  require("mush").setup({ terminal_colors = false })
  vim.cmd.colorscheme("mush-dark")
  assert_equal(vim.g.terminal_color_0, "#123456")

  require("mush").setup({ terminal_colors = true })
  vim.cmd.colorscheme("mush-light")
  assert_equal(vim.g.terminal_color_0, "#f8faf7")
  assert_equal(vim.g.terminal_color_15, "#000000")
end)

test("clean loading does not require providers or plugins", function()
  local optional_modules = {
    "blink.cmp",
    "cmp",
    "gitsigns",
    "neo-tree",
    "nvim-tree",
    "telescope",
    "trouble",
    "which-key",
  }

  for _, module in ipairs(optional_modules) do
    assert_equal(package.loaded[module], nil, "optional module was loaded: " .. module)
  end

  vim.cmd.colorscheme("mush-dark")
  vim.cmd.colorscheme("mush-light")
end)

if failures > 0 then
  print(string.format("%d tests passed; %d failed", completed, failures))
  vim.cmd("cquit 1")
else
  print(string.format("%d tests passed", completed))
  vim.cmd.quit()
end
