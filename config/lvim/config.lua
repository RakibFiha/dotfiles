-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
local function open_nvim_tree()
require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree})

lvim.icons.ui.Folder = "󰉋"
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.default = lvim.icons.ui.Folder

lvim.transparent_window = true

lvim.plugins = {
{
"zbirenbaum/copilot.lua",
cmd = "Copilot",
event = "InsertEnter",
config = function()
require("copilot").setup({})
end,
},
{
"zbirenbaum/copilot-cmp",
config = function ()
require("copilot_cmp").setup({
suggestion = { enabled = false },
panel = { enabled = false }
})
end
}
}

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}

-- Below config is required to prevent copilot overriding Tab with a suggestion
-- when you're just trying to indent!
local has_words_before = function()
if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
local line, col = unpack(vim.api.nvim_win_get_cursor(0))
return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
local on_tab = vim.schedule_wrap(function(fallback)
local cmp = require("cmp")
if cmp.visible() and has_words_before() then
cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
else
fallback()
end
end)
lvim.builtin.cmp.mapping["<Tab>"] = on_tab
