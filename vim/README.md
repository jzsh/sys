## Vim Confiration
### a personal vimrc file
.vim/syntax/yang.vim can be download from http://yang-central.org/
.vim/syntax/uci.vim can download as:

	git clone git://github.com/cmcaine/vim-uci.git

QUICK TIP: DISABLE HELP (F1) IN GNOME-TERMINAL:http://www.cmdln.org/2010/12/28/quick-tip-disable-help-f1-in-gnome-terminal/
>Gnome-terminal has the ability to set (or disable) keyboard shortcuts just for gnome-terminal by navigating to Edit -> Keyboard Shortcuts. You can find the help shortcut pretty easily and clicking on it allows you to remap the keyboard shortcut but what is not so obvious at least to me was how to disable the shortcut. Well a bit of searching finally turned up the solution. Use backspace to remap the key to “Disabled”.

:help be your reference, and this page be your guide to Vim's indentation options.

https://vim.fandom.com/wiki/Indenting_source_code
'tabstop' changes the width of the TAB character, plain and simple.
'softtabstop' affects what happens when you press the <TAB> or <BS> keys. Its default value is the same as the value of 'tabstop', but when using indentation without hard tabs or mixed indentation, you want to set it to the same value as 'shiftwidth'. If 'expandtab' is unset, and 'tabstop' is different from 'softtabstop', the <TAB> key will minimize the amount of spaces inserted by using multiples of TAB characters. For instance, if 'tabstop' is 8, and the amount of consecutive space inserted is 20, two TAB characters and four spaces will be used.
'shiftwidth' affects what happens when you press >>, << or ==. It also affects how automatic indentation works. (See below.)
'expandtab' affects what happens when you press the <TAB> key. If 'expandtab' is set, pressing the <TAB> key will always insert 'softtabstop' amount of space characters. Otherwise, the amount of spaces inserted is minimized by using TAB characters.
'smarttab' affects how <TAB> key presses are interpreted depending on where the cursor is. If 'smarttab' is on, a <TAB> key inserts indentation according to 'shiftwidth' at the beginning of the line, whereas 'tabstop' and  'softtabstop' are used elsewhere. There is seldom any need to set this option, unless it is necessary to use hard  TAB characters in body text or code.
