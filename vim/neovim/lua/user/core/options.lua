local options = {
  -- Basic
  -- backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  -- cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  -- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  -- conceallevel = 0,                        -- so that `` is visible in markdown files
  -- fileencoding = "utf-8",                  -- the encoding written to a file
  autochdir = true,
 
  -- Search
  hlsearch = true,                            -- highlight all matches on previous search pattern
  incsearch = true,
  smartcase = true,                           -- smart case
  ignorecase = true,                          -- ignore case in search patterns

  -- mouse = "a",                             -- allow the mouse to be used in neovim
  -- pumheight = 10,                          -- pop up menu height
  -- showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  -- showtabline = 2,                         -- always show tabs
 
  -- Window
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window

  -- swapfile = false,                        -- creates a swapfile
  -- timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  -- undofile = true,                         -- enable persistent undo
  --
  -- updatetime = 300,                        -- faster completion (4000ms default)
  -- writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
 
  -- Indenting
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4 ,                            -- insert n spaces for a tab
  autoindent = true,
  smartindent = true,                      -- make indenting smarter again

  -- cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = false,                  -- set relative numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}

  -- Viewing
  wrap = false,                             -- display lines as one long line
  linebreak = true,                        -- companion to wrap, don't split words
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  -- termguicolors = true,                    -- set term gui colors (most terminals support this)
  -- background = "dark",
  list = true,                              -- show special char
  listchars = "tab:> ,trail:.",             -- char for tab and trailing space
  cursorline = true,                        -- show cursor line
  -- status bar
  statusline = "[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]",
  laststatus = 2,                           -- always show the status line

  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,                       -- minimal number of screen columns either side of cursor if wrap is `false`
  -- guifont = "monospace:h17",               -- the font used in graphical neovim applications
  -- whichwrap = "bs<>[]hl",                  -- which "horizontal" keys are allowed to travel to prev/next line
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append "c"                           -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-"                           -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" })        -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use


