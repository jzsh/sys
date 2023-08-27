local lspconfig = require('lspconfig')

-- 定义快捷键
-- 根据官方的提示，这里我们使用 on_attach 表示当前缓冲加载服务端完成之后调用
local on_attach_fn = function(client, bufnr)
    -- 跳转到声明
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", {silent = true, noremap = true})
    -- 跳转到定义
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", {silent = true, noremap = true})
    -- 显示注释文档
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {silent = true, noremap = true})
    -- 跳转到实现
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {silent = true, noremap = true})
    -- 跳转到引用位置
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {silent = true, noremap = true})
    -- 以浮窗形式显示错误
    vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", {silent = true, noremap = true})
end


-- upward find root dir from current dir
-- local root_dir_fn = lspconfig.util.root_pattern('README', 'compile_commands.json')
-- print(root_dir_fn)
-- local root_dir = root_dir_fn()
-- print(root_dir)
-- local comp_commands_dir = root_dir .. 'build'

-- print(vim.fn.system('pwd'))
-- print(vim.fs.find({'README.md'}, { upward = true })[1])

local root_dir = vim.fs.dirname(vim.fs.find({'README.md'}, { upward = true })[1])
local comp_commands_dir = "--compile-commands-dir=" .. root_dir .. '/build'

lspconfig.clangd.setup{
    cmd = { 'clangd', '--background-index', comp_commands_dir },
    filetype = {'c', 'cpp'},
	root_dir = lspconfig.util.root_pattern('README', 'compile_commands.json'),
	on_attach = on_attach_fn
}



