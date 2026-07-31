local M = {}

function M.apply(palette)
  local groups = {
    LspReferenceText = { bg = "bg_highlight" },
    LspReferenceRead = { bg = "bg_highlight" },
    LspReferenceWrite = { bg = "bg_visual", bold = true },
    LspReferenceTarget = { bg = "bg_visual", bold = true },
    LspInlayHint = { fg = "subtle", bg = "bg_elevated", italic = true },
    LspCodeLens = { fg = "subtle", italic = true },
    LspCodeLensSeparator = { fg = "subtle" },
    LspSignatureActiveParameter = { fg = "bright_yellow", bold = true },

    ["@lsp.type.class"] = { link = "Type" },
    ["@lsp.type.comment"] = { link = "Comment" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "Type" },
    ["@lsp.type.enumMember"] = { link = "Constant" },
    ["@lsp.type.event"] = { fg = "pink" },
    ["@lsp.type.function"] = { link = "Function" },
    ["@lsp.type.interface"] = { fg = "purple", bold = true },
    ["@lsp.type.keyword"] = { link = "Keyword" },
    ["@lsp.type.macro"] = { link = "Macro" },
    ["@lsp.type.method"] = { fg = "bright_blue" },
    ["@lsp.type.modifier"] = { link = "Keyword" },
    ["@lsp.type.namespace"] = { fg = "purple" },
    ["@lsp.type.number"] = { link = "Number" },
    ["@lsp.type.operator"] = { link = "Operator" },
    ["@lsp.type.parameter"] = { fg = "fg", italic = true },
    ["@lsp.type.property"] = { fg = "fg" },
    ["@lsp.type.regexp"] = { link = "@string.regexp" },
    ["@lsp.type.string"] = { link = "String" },
    ["@lsp.type.struct"] = { link = "Type" },
    ["@lsp.type.type"] = { link = "Type" },
    ["@lsp.type.typeParameter"] = { fg = "bright_cyan", bold = true },
    ["@lsp.type.variable"] = { fg = "fg" },
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.mod.documentation"] = { italic = true },
    ["@lsp.mod.readonly"] = { bold = true },
    ["@lsp.typemod.variable.readonly"] = { link = "Constant" },
    ["@lsp.typemod.property.readonly"] = { fg = "pink" },
  }

  require("mush.groups.util").apply(palette, groups)
end

return M
