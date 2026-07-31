local M = {}

function M.apply(palette)
  local groups = {
    -- Rust Tree-sitter distinguishes lifetimes from loop labels.
    ["@attribute.rust"] = { fg = "pink", italic = true },
    ["@attribute.builtin.rust"] = { fg = "bright_purple", italic = true },
    ["@label.rust"] = { fg = "orange", italic = true },
    ["@function.macro.rust"] = { fg = "orange", bold = true },
    ["@keyword.modifier.rust"] = { fg = "red" },
    ["@keyword.coroutine.rust"] = { fg = "purple", bold = true },
    ["@module.rust"] = { fg = "purple" },
    ["@type.rust"] = { fg = "cyan", bold = true },
    ["@type.builtin.rust"] = { fg = "bright_cyan", bold = true },
    ["@constant.rust"] = { fg = "pink" },
    ["@constant.builtin.rust"] = { fg = "bright_purple", bold = true },
    ["@variable.builtin.rust"] = { fg = "purple", italic = true },
    ["@variable.member.rust"] = { fg = "fg" },

    -- rust-analyzer semantic token types.
    ["@lsp.type.struct.rust"] = { fg = "cyan", bold = true },
    ["@lsp.type.enum.rust"] = { fg = "cyan", bold = true },
    ["@lsp.type.union.rust"] = { fg = "cyan", bold = true },
    ["@lsp.type.type.rust"] = { fg = "cyan", bold = true },
    ["@lsp.type.interface.rust"] = { fg = "purple", bold = true },
    ["@lsp.type.typeParameter.rust"] = { fg = "bright_cyan", bold = true, underline = true },
    ["@lsp.type.enumMember.rust"] = { fg = "pink", bold = true },
    ["@lsp.type.function.rust"] = { fg = "blue" },
    ["@lsp.type.method.rust"] = { fg = "bright_blue" },
    ["@lsp.type.macro.rust"] = { fg = "orange", bold = true },
    ["@lsp.type.namespace.rust"] = { fg = "purple" },
    ["@lsp.type.decorator.rust"] = { fg = "yellow", italic = true },
    ["@lsp.type.lifetime.rust"] = { fg = "pink", italic = true },
    ["@lsp.type.label.rust"] = { fg = "orange", italic = true },
    ["@lsp.type.selfKeyword.rust"] = { fg = "purple", italic = true },
    ["@lsp.type.formatSpecifier.rust"] = { fg = "cyan", bold = true },
    ["@lsp.type.parameter.rust"] = { fg = "fg", italic = true },
    ["@lsp.type.property.rust"] = { fg = "fg" },
    ["@lsp.type.variable.rust"] = { fg = "fg" },

    -- Modifiers add styling without replacing the token's semantic color.
    ["@lsp.mod.mutable.rust"] = { underline = true },
    ["@lsp.typemod.variable.mutable.rust"] = { underline = true },
    ["@lsp.typemod.parameter.mutable.rust"] = { underline = true },
    ["@lsp.typemod.property.mutable.rust"] = { underline = true },
    ["@lsp.mod.unsafe.rust"] = { fg = "orange", italic = true },
    ["@lsp.typemod.function.unsafe.rust"] = { fg = "orange", italic = true },
    ["@lsp.typemod.method.unsafe.rust"] = { fg = "orange", italic = true },
    ["@lsp.typemod.keyword.unsafe.rust"] = { fg = "orange", italic = true },
    ["@lsp.typemod.variable.readonly.rust"] = { fg = "pink", bold = true },
    ["@lsp.typemod.property.readonly.rust"] = { fg = "pink" },
    ["@lsp.mod.attribute.rust"] = { fg = "yellow", italic = true },
    ["@lsp.mod.documentation.rust"] = { italic = true },
    ["@lsp.mod.controlFlow.rust"] = { bold = true },
  }

  require("mush.groups.util").apply(palette, groups)
end

return M
