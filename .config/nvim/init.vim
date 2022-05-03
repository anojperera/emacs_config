syntax on

set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set hidden
set encoding=utf-8
set showtabline=0
set background=dark
set clipboard=unnamed
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#ff0000 ctermbg=234
set bs=2
set wrap linebreak nolist

" Plugins
call plug#begin('~/.config/nvim/plugged')
" Theme
Plug 'git@github.com:joshdick/onedark.vim.git'

Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-bufferline'
Plug 'git@github.com:ctrlpvim/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'git@github.com:airblade/vim-rooter.git'
Plug 'git@github.com:jiangmiao/auto-pairs.git'

" lsp configurations
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" End of Plugins
call plug#end()

colorscheme onedark

" Custom function for delete trailing spaces
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//e
  exe "normal `z"
endfunc
set modelines=1
let mapleader = " "

if executable('ag')
  let g:ackprg = 'ag --vimgrep'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" " ag is fast enough that CtrlP doesn't need to cache let g:ctrlp_use_caching = 0
endi

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " ...
endif

let g:python3_host_prog = '/usr/local/opt/python@3.9/bin/python3'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:airline_theme='deus'
let g:fzf_layout = { 'down': '~40%' }

set completeopt=menu,menuone,noselect
lua <<EOF
-- Lua

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'powerline',
      component_separators = { left = '|', right = '|'},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = false,
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach_lspconfig = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  require("nvim-lsp-installer").setup{}

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  require'lspconfig'.jedi_language_server.setup{
    capabilities = capabilities,
    cmd = { "jedi-language-server" },
    filetypes = {"python"}
    }

  require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    init_options = {
      hostInfo = "neovim"
    }
  }

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>

nnoremap <C-f> :Files<CR>
" Remapped keys for navigating windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>v :wincmd v<CR>
nnoremap <leader>s :wincmd s<CR>
nnoremap <leader>q :wincmd q<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>-5 :vertical resize -5<CR>
nnoremap <leader>1 :only<CR>
nnoremap <Leader>b :ls<CR>:b<Space>

" nnoremap <silent> <leader>gd :LspDefinition<CR>
" nnoremap <silent> <leader>gr :LspReferences<CR>
" nnoremap <silent> <leader>gp :LspPeekTypeDefinition<CR>
" nnoremap <silent> <leader>gc :LspCodeLens<CR>

" nnoremap <silent> <leader>ff :lua  vim.lsp.buf.formatting_sync()<CR>
" Git shortcuts
nnoremap <leader>gs :G<CR>

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>t :NERDTreeFind<CR>

" Delete trailing spaces
nnoremap <leader>w :call DeleteTrailingWS()<CR>
autocmd BufWritePre * :%s/\s\+$//e
