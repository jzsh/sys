-- local colorscheme = "desert"
local colorscheme = "tokyonight-storm"
-- local colorscheme = "tokyonight-night"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    print "can not load colorschema"
    return
end

