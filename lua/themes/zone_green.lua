-- Zone Green theme for Neovim
-- Based on VSCode Zone Green theme by Convolution

local M = {}

M.colors = {
  -- Background colors
  bg = "#000000",
  bg_highlight = "#103d00",
  bg_selection = "#1d6b00",
  
  -- Foreground colors
  fg = "#bfbfbf",
  fg_bright = "#5afe01",
  fg_normal = "#3eb300",
  fg_muted = "#1d6b00",
  
  -- Syntax colors (from VSCode theme)
  comment = "#949494",
  string = "#00C78B",
  keyword = "#3396FF",
  storage = "#3396FF",
  type = "#7C5CFF",
  function_name = "#FFFFB3",
  variable = "#7AF4FF",
  constant = "#FF5252",
  number = "#FF5252",
  operator = "#D4D4D4",
  
  -- UI colors
  cursor = "#5afe01",
  line_nr = "#1d6b00",
  line_nr_active = "#5afe01",
  visual = "#1d6b00",
  search = "#101010",
  search_border = "#ffd342",
  
  -- Git colors
  git_add = "#00c78b",
  git_change = "#ffd342",
  git_delete = "#ff5252",
  
  -- Diagnostic colors
  error = "#ff5252",
  warning = "#ffd342",
  info = "#335fff",
}

M.setup = function()
  -- Set colorscheme
  vim.opt.background = "dark"
  
  -- Clear existing highlights
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  

  
  -- Define highlights
  local highlights = {
    -- Editor
    Normal = { fg = M.colors.fg, bg = M.colors.bg },
    NormalNC = { fg = M.colors.fg, bg = M.colors.bg },
    CursorLine = { bg = M.colors.bg_highlight },
    CursorLineNr = { fg = M.colors.line_nr_active, bg = M.colors.bg_highlight },
    LineNr = { fg = M.colors.line_nr, bg = M.colors.bg },
    Visual = { bg = M.colors.visual },
    Search = { bg = M.colors.search, fg = M.colors.fg_bright },
    IncSearch = { bg = M.colors.search_border, fg = M.colors.bg },
    
    -- Syntax
    Comment = { fg = M.colors.comment, italic = true },
    String = { fg = M.colors.string },
    Constant = { fg = M.colors.constant },
    Number = { fg = M.colors.number },
    Boolean = { fg = M.colors.constant },
    Float = { fg = M.colors.number },
    
    Identifier = { fg = M.colors.variable },
    Function = { fg = M.colors.function_name },
    
    Statement = { fg = M.colors.keyword },
    Keyword = { fg = M.colors.keyword },
    Conditional = { fg = M.colors.keyword },
    Repeat = { fg = M.colors.keyword },
    Label = { fg = M.colors.keyword },
    Operator = { fg = M.colors.operator },
    Exception = { fg = M.colors.keyword },
    
    PreProc = { fg = M.colors.keyword },
    Include = { fg = M.colors.keyword },
    Define = { fg = M.colors.keyword },
    Macro = { fg = M.colors.keyword },
    PreCondit = { fg = M.colors.keyword },
    
    Type = { fg = M.colors.type },
    StorageClass = { fg = M.colors.storage },
    Structure = { fg = M.colors.type },
    Typedef = { fg = M.colors.type },
    
    Special = { fg = M.colors.function_name },
    SpecialChar = { fg = M.colors.string },
    Tag = { fg = M.colors.keyword },
    Delimiter = { fg = M.colors.operator },
    SpecialComment = { fg = M.colors.comment, italic = true },
    Debug = { fg = M.colors.warning },
    
    -- UI
    StatusLine = { fg = M.colors.fg_normal, bg = M.colors.bg_highlight },
    StatusLineNC = { fg = M.colors.fg_muted, bg = M.colors.bg },
    TabLine = { fg = M.colors.fg_normal, bg = M.colors.bg },
    TabLineSel = { fg = M.colors.fg_bright, bg = M.colors.bg_selection, bold = true },
    TabLineFill = { fg = M.colors.bg, bg = M.colors.bg },
    
    Pmenu = { fg = M.colors.fg, bg = M.colors.bg_highlight },
    PmenuSel = { fg = M.colors.fg_bright, bg = M.colors.bg_selection },
    PmenuSbar = { bg = M.colors.bg_muted },
    PmenuThumb = { bg = M.colors.fg_normal },
    
    WildMenu = { fg = M.colors.fg_bright, bg = M.colors.bg_selection },
    
    -- Fold
    Folded = { fg = M.colors.comment, bg = M.colors.bg },
    FoldColumn = { fg = M.colors.line_nr, bg = M.colors.bg },
    
    -- Diff
    DiffAdd = { fg = M.colors.git_add, bg = M.colors.bg_highlight },
    DiffChange = { fg = M.colors.git_change, bg = M.colors.bg_highlight },
    DiffDelete = { fg = M.colors.git_delete, bg = M.colors.bg_highlight },
    DiffText = { fg = M.colors.git_change, bg = M.colors.bg_selection },
    
    -- Sign column
    SignColumn = { fg = M.colors.line_nr, bg = M.colors.bg },
    
    -- Cursor
    Cursor = { fg = M.colors.bg, bg = M.colors.cursor },
    CursorIM = { fg = M.colors.bg, bg = M.colors.cursor },
    
    -- Misc
    Directory = { fg = M.colors.function_name },
    Title = { fg = M.colors.fg_bright, bold = true },
    ErrorMsg = { fg = M.colors.error, bg = M.colors.bg },
    WarningMsg = { fg = M.colors.warning, bg = M.colors.bg },
    ModeMsg = { fg = M.colors.fg },
    MoreMsg = { fg = M.colors.fg_bright },
    Question = { fg = M.colors.fg_bright },
    
    -- NonText
    NonText = { fg = M.colors.fg_muted },
    EndOfBuffer = { fg = M.colors.fg_muted },
    
    -- MatchParen
    MatchParen = { fg = M.colors.fg_bright, bg = M.colors.bg_selection, bold = true },
    
    -- Spell
    SpellBad = { fg = M.colors.error, undercurl = true },
    SpellCap = { fg = M.colors.warning, undercurl = true },
    SpellLocal = { fg = M.colors.info, undercurl = true },
    SpellRare = { fg = M.colors.type, undercurl = true },
    
    -- Diagnostic
    DiagnosticError = { fg = M.colors.error },
    DiagnosticWarn = { fg = M.colors.warning },
    DiagnosticInfo = { fg = M.colors.info },
    DiagnosticHint = { fg = M.colors.function_name },
    
    DiagnosticUnderlineError = { fg = M.colors.error, undercurl = true },
    DiagnosticUnderlineWarn = { fg = M.colors.warning, undercurl = true },
    DiagnosticUnderlineInfo = { fg = M.colors.info, undercurl = true },
    DiagnosticUnderlineHint = { fg = M.colors.function_name, undercurl = true },
    
    -- Floating window
    NormalFloat = { fg = M.colors.fg, bg = M.colors.bg_highlight },
    FloatBorder = { fg = M.colors.fg_normal, bg = M.colors.bg_highlight },
    
    -- TreeSitter
    ["@variable"] = { fg = M.colors.variable },
    ["@variable.builtin"] = { fg = M.colors.keyword },
    ["@variable.parameter"] = { fg = M.colors.fg },
    ["@variable.member"] = { fg = M.colors.variable },
    
    ["@constant"] = { fg = M.colors.constant },
    ["@constant.builtin"] = { fg = M.colors.constant },
    ["@constant.macro"] = { fg = M.colors.keyword },
    
    ["@module"] = { fg = M.colors.type },
    ["@module.builtin"] = { fg = M.colors.type },
    
    ["@label"] = { fg = M.colors.keyword },
    
    ["@string"] = { fg = M.colors.string },
    ["@string.documentation"] = { fg = M.colors.string, italic = true },
    ["@string.regexp"] = { fg = M.colors.string },
    ["@string.escape"] = { fg = M.colors.function_name },
    ["@string.special"] = { fg = M.colors.function_name },
    ["@string.special.symbol"] = { fg = M.colors.constant },
    ["@string.special.url"] = { fg = M.colors.string, underline = true },
    ["@string.special.path"] = { fg = M.colors.string },
    
    ["@character"] = { fg = M.colors.string },
    ["@character.special"] = { fg = M.colors.function_name },
    
    ["@boolean"] = { fg = M.colors.constant },
    ["@number"] = { fg = M.colors.number },
    ["@number.float"] = { fg = M.colors.number },
    
    ["@type"] = { fg = M.colors.type },
    ["@type.builtin"] = { fg = M.colors.type },
    ["@type.definition"] = { fg = M.colors.type },
    ["@type.qualifier"] = { fg = M.colors.storage },
    
    ["@attribute"] = { fg = M.colors.function_name },
    ["@property"] = { fg = M.colors.variable },
    
    ["@function"] = { fg = M.colors.function_name },
    ["@function.builtin"] = { fg = M.colors.function_name },
    ["@function.call"] = { fg = M.colors.function_name },
    ["@function.macro"] = { fg = M.colors.keyword },
    ["@function.method"] = { fg = M.colors.function_name },
    ["@function.method.call"] = { fg = M.colors.function_name },
    
    ["@constructor"] = { fg = M.colors.type },
    
    ["@operator"] = { fg = M.colors.operator },
    
    ["@keyword"] = { fg = M.colors.keyword },
    ["@keyword.coroutine"] = { fg = M.colors.keyword },
    ["@keyword.function"] = { fg = M.colors.keyword },
    ["@keyword.operator"] = { fg = M.colors.keyword },
    ["@keyword.import"] = { fg = M.colors.keyword },
    ["@keyword.type"] = { fg = M.colors.storage },
    ["@keyword.modifier"] = { fg = M.colors.storage },
    ["@keyword.repeat"] = { fg = M.colors.keyword },
    ["@keyword.return"] = { fg = M.colors.keyword },
    ["@keyword.debug"] = { fg = M.colors.keyword },
    ["@keyword.exception"] = { fg = M.colors.keyword },
    
    ["@keyword.conditional"] = { fg = M.colors.keyword },
    ["@keyword.conditional.ternary"] = { fg = M.colors.keyword },
    
    ["@keyword.directive"] = { fg = M.colors.keyword },
    ["@keyword.directive.define"] = { fg = M.colors.keyword },
    
    ["@punctuation.delimiter"] = { fg = M.colors.operator },
    ["@punctuation.bracket"] = { fg = M.colors.operator },
    ["@punctuation.special"] = { fg = M.colors.keyword },
    
    ["@comment"] = { fg = M.colors.comment, italic = true },
    ["@comment.documentation"] = { fg = M.colors.comment, italic = true },
    ["@comment.error"] = { fg = M.colors.error },
    ["@comment.warning"] = { fg = M.colors.warning },
    ["@comment.todo"] = { fg = M.colors.warning, bold = true },
    ["@comment.note"] = { fg = M.colors.info },
    
    ["@markup.strong"] = { fg = M.colors.fg, bold = true },
    ["@markup.italic"] = { fg = M.colors.fg, italic = true },
    ["@markup.strikethrough"] = { fg = M.colors.fg, strikethrough = true },
    ["@markup.underline"] = { fg = M.colors.fg, underline = true },
    
    ["@markup.heading"] = { fg = M.colors.fg_bright, bold = true },
    ["@markup.heading.1"] = { fg = M.colors.fg_bright, bold = true },
    ["@markup.heading.2"] = { fg = M.colors.fg_bright, bold = true },
    ["@markup.heading.3"] = { fg = M.colors.fg_bright, bold = true },
    ["@markup.heading.4"] = { fg = M.colors.fg_bright, bold = true },
    ["@markup.heading.5"] = { fg = M.colors.fg_bright, bold = true },
    ["@markup.heading.6"] = { fg = M.colors.fg_bright, bold = true },
    
    ["@markup.quote"] = { fg = M.colors.comment, italic = true },
    ["@markup.math"] = { fg = M.colors.type },
    ["@markup.environment"] = { fg = M.colors.type },
    ["@markup.environment.name"] = { fg = M.colors.type },
    
    ["@markup.link"] = { fg = M.colors.string, underline = true },
    ["@markup.link.label"] = { fg = M.colors.string },
    ["@markup.link.url"] = { fg = M.colors.string, underline = true },
    ["@markup.raw"] = { fg = M.colors.string },
    ["@markup.raw.block"] = { fg = M.colors.string },
    
    ["@markup.list"] = { fg = M.colors.fg_bright },
    ["@markup.list.checked"] = { fg = M.colors.git_add },
    ["@markup.list.unchecked"] = { fg = M.colors.fg_muted },
    
    ["@diff.plus"] = { fg = M.colors.git_add },
    ["@diff.minus"] = { fg = M.colors.git_delete },
    ["@diff.delta"] = { fg = M.colors.git_change },
    
    ["@tag"] = { fg = M.colors.keyword },
    ["@tag.attribute"] = { fg = M.colors.variable },
    ["@tag.delimiter"] = { fg = M.colors.operator },
    
    -- LSP
    LspReferenceText = { bg = M.colors.bg_selection },
    LspReferenceRead = { bg = M.colors.bg_selection },
    LspReferenceWrite = { bg = M.colors.bg_selection },
    
    LspSignatureActiveParameter = { fg = M.colors.fg_bright, bg = M.colors.bg_selection },
    
    -- GitSigns
    GitSignsAdd = { fg = M.colors.git_add },
    GitSignsChange = { fg = M.colors.git_change },
    GitSignsDelete = { fg = M.colors.git_delete },
    
    -- Telescope
    TelescopeSelection = { fg = M.colors.fg_bright, bg = M.colors.bg_selection },
    TelescopeSelectionCaret = { fg = M.colors.fg_bright, bg = M.colors.bg_selection },
    TelescopeMultiSelection = { fg = M.colors.type },
    TelescopeNormal = { fg = M.colors.fg, bg = M.colors.bg },
    TelescopePreviewNormal = { fg = M.colors.fg, bg = M.colors.bg },
    TelescopePromptNormal = { fg = M.colors.fg, bg = M.colors.bg_highlight },
    TelescopeResultsNormal = { fg = M.colors.fg, bg = M.colors.bg },
    
    TelescopeBorder = { fg = M.colors.fg_normal, bg = M.colors.bg },
    TelescopePromptBorder = { fg = M.colors.fg_normal, bg = M.colors.bg_highlight },
    TelescopeResultsBorder = { fg = M.colors.fg_normal, bg = M.colors.bg },
    TelescopePreviewBorder = { fg = M.colors.fg_normal, bg = M.colors.bg },
    
    TelescopeMatching = { fg = M.colors.fg_bright, bold = true },
    TelescopePromptPrefix = { fg = M.colors.fg_bright },
    TelescopePromptCounter = { fg = M.colors.comment },
    
    -- BufferLine (bufferline.nvim)
    BufferLineFill = { fg = M.colors.fg_normal, bg = M.colors.bg },
    BufferLineBackground = { fg = M.colors.fg_normal, bg = M.colors.bg },
    BufferLineBufferVisible = { fg = M.colors.fg_normal, bg = M.colors.bg_highlight },
    BufferLineBufferSelected = { fg = M.colors.fg_bright, bg = M.colors.bg_selection, bold = true },
    BufferLineTab = { fg = M.colors.fg_normal, bg = M.colors.bg },
    BufferLineTabSelected = { fg = M.colors.fg_bright, bg = M.colors.bg_selection, bold = true },
    BufferLineTabClose = { fg = M.colors.git_delete, bg = M.colors.bg },
    BufferLineSeparator = { fg = M.colors.fg_muted, bg = M.colors.bg },
    BufferLineSeparatorVisible = { fg = M.colors.fg_muted, bg = M.colors.bg_highlight },
    BufferLineSeparatorSelected = { fg = M.colors.fg_muted, bg = M.colors.bg_selection },
    BufferLineIndicatorSelected = { fg = M.colors.fg_bright, bg = M.colors.bg_selection },
    BufferLineModified = { fg = M.colors.git_change, bg = M.colors.bg },
    BufferLineModifiedVisible = { fg = M.colors.git_change, bg = M.colors.bg_highlight },
    BufferLineModifiedSelected = { fg = M.colors.git_change, bg = M.colors.bg_selection },
    BufferLineDuplicate = { fg = M.colors.fg_muted, bg = M.colors.bg },
    BufferLineDuplicateVisible = { fg = M.colors.fg_muted, bg = M.colors.bg_highlight },
    BufferLineDuplicateSelected = { fg = M.colors.fg_muted, bg = M.colors.bg_selection },
    BufferLinePick = { fg = M.colors.fg_bright, bg = M.colors.bg_selection, bold = true },
    BufferLinePickSelected = { fg = M.colors.fg_bright, bg = M.colors.bg_selection, bold = true },
    BufferLineError = { fg = M.colors.error, bg = M.colors.bg },
    BufferLineErrorVisible = { fg = M.colors.error, bg = M.colors.bg_highlight },
    BufferLineErrorSelected = { fg = M.colors.error, bg = M.colors.bg_selection },
    BufferLineWarning = { fg = M.colors.warning, bg = M.colors.bg },
    BufferLineWarningVisible = { fg = M.colors.warning, bg = M.colors.bg_highlight },
    BufferLineWarningSelected = { fg = M.colors.warning, bg = M.colors.bg_selection },
    BufferLineInfo = { fg = M.colors.info, bg = M.colors.bg },
    BufferLineInfoVisible = { fg = M.colors.info, bg = M.colors.bg_highlight },
    BufferLineInfoSelected = { fg = M.colors.info, bg = M.colors.bg_selection },
    BufferLineHint = { fg = M.colors.function_name, bg = M.colors.bg },
    BufferLineHintVisible = { fg = M.colors.function_name, bg = M.colors.bg_highlight },
    BufferLineHintSelected = { fg = M.colors.function_name, bg = M.colors.bg_selection },
    BufferLineNumbers = { fg = M.colors.fg_normal, bg = M.colors.bg },
    BufferLineNumbersVisible = { fg = M.colors.fg_normal, bg = M.colors.bg_highlight },
    BufferLineNumbersSelected = { fg = M.colors.fg_bright, bg = M.colors.bg_selection, bold = true },
    BufferLineCloseButton = { fg = M.colors.git_delete, bg = M.colors.bg },
    BufferLineCloseButtonVisible = { fg = M.colors.git_delete, bg = M.colors.bg_highlight },
    BufferLineCloseButtonSelected = { fg = M.colors.git_delete, bg = M.colors.bg_selection },
    BufferLineDiagnostic = { fg = M.colors.error, bg = M.colors.bg },
    BufferLineDiagnosticVisible = { fg = M.colors.error, bg = M.colors.bg_highlight },
    BufferLineDiagnosticSelected = { fg = M.colors.error, bg = M.colors.bg_selection },
    
    -- WhichKey
    WhichKey = { fg = M.colors.fg_bright },
    WhichKeyGroup = { fg = M.colors.type },
    WhichKeyDesc = { fg = M.colors.function_name },
    WhichKeySeparator = { fg = M.colors.comment },
    WhichKeyFloat = { fg = M.colors.fg, bg = M.colors.bg_highlight },
    WhichKeyValue = { fg = M.colors.comment },
    
    -- CMP
    CmpItemAbbr = { fg = M.colors.fg },
    CmpItemAbbrDeprecated = { fg = M.colors.comment, strikethrough = true },
    CmpItemAbbrMatch = { fg = M.colors.fg_bright, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = M.colors.fg_bright, bold = true },
    CmpItemKind = { fg = M.colors.type },
    CmpItemMenu = { fg = M.colors.comment },
    
    CmpItemKindText = { fg = M.colors.fg },
    CmpItemKindMethod = { fg = M.colors.function_name },
    CmpItemKindFunction = { fg = M.colors.function_name },
    CmpItemKindConstructor = { fg = M.colors.type },
    CmpItemKindField = { fg = M.colors.variable },
    CmpItemKindVariable = { fg = M.colors.variable },
    CmpItemKindClass = { fg = M.colors.type },
    CmpItemKindInterface = { fg = M.colors.type },
    CmpItemKindModule = { fg = M.colors.type },
    CmpItemKindProperty = { fg = M.colors.variable },
    CmpItemKindUnit = { fg = M.colors.constant },
    CmpItemKindValue = { fg = M.colors.constant },
    CmpItemKindEnum = { fg = M.colors.type },
    CmpItemKindKeyword = { fg = M.colors.keyword },
    CmpItemKindSnippet = { fg = M.colors.function_name },
    CmpItemKindColor = { fg = M.colors.constant },
    CmpItemKindFile = { fg = M.colors.fg },
    CmpItemKindReference = { fg = M.colors.fg },
    CmpItemKindFolder = { fg = M.colors.fg },
    CmpItemKindEnumMember = { fg = M.colors.constant },
    CmpItemKindConstant = { fg = M.colors.constant },
    CmpItemKindStruct = { fg = M.colors.type },
    CmpItemKindEvent = { fg = M.colors.keyword },
    CmpItemKindOperator = { fg = M.colors.operator },
    CmpItemKindTypeParameter = { fg = M.colors.type },
  }
  
  -- Apply highlights
  for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return M