local colorscheme = "desert"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  print "can not loal coloeschema"
  return
end
