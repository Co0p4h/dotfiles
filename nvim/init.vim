set tabstop=2
set shiftwidth=2
set softtabstop=2
set relativenumber
set expandtab
set autoindent
set smartindent
set ignorecase
set mouse=a
set title
set nohlsearch
set incsearch
set hidden
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/undodir
set undofile
set scrolloff=6
set clipboard+=unnamedplus " set copy to system clipboard

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'folke/tokyonight.nvim'
Plug 'morhetz/gruvbox'
Plug 'marko-cerovac/material.nvim'
Plug 'rebelot/kanagawa.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" status bar
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

" file tree
Plug 'nvim-tree/nvim-tree.lua'

" other...
Plug 'numToStr/Comment.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'lewis6991/gitsigns.nvim'

" lsp stuff for now
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v4.x'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" discord status
Plug 'vyfor/cord.nvim', { 'do': './build' }

call plug#end()

lua << END
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "rust", "python" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}
END

lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {},
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
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
END

lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 25,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
vim.api.nvim_set_keymap("n", "<space>f", ":NvimTreeFocus<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<space>e", ":NvimTreeToggle<CR>", { noremap = true })
EOF

lua << END
require('Comment').setup()
vim.api.nvim_set_keymap('n', '<D-/>', ':normal gcc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-/>', ':normal gcc<CR>', { noremap = true, silent = true })
END

lua << END
require('gitsigns').setup()
END


lua << END
require('cord').setup({
  usercmds = true,                              -- Enable user commands
  log_level = 'error',                          -- One of 'trace', 'debug', 'info', 'warn', 'error', 'off'
  timer = {
    interval = 2000,                            -- Interval between presence updates in milliseconds (min 500)
    reset_on_idle = false,                      -- Reset start timestamp on idle
    reset_on_change = false,                    -- Reset start timestamp on presence change
  },
  editor = {
    image = nil,                                -- Image ID or URL in case a custom client id is provided
    client = 'neovim',                          -- vim, neovim, lunarvim, nvchad, astronvim or your application's client id
    tooltip = 'kys :D',       -- Text to display when hovering over the editor's image
  },
  display = {
    show_time = true,                           -- Display start timestamp
    show_repository = false,                     -- Display 'View repository' button linked to repository url, if any
    show_cursor_position = false,               -- Display line and column number of cursor's position
    swap_fields = false,                        -- If enabled, workspace is displayed first
    swap_icons = true,                         -- If enabled, editor is displayed on the main image
    workspace_blacklist = {},                   -- List of workspace names to hide
  },
  lsp = {
    show_problem_count = false,                 -- Display number of diagnostics problems
    severity = 1,                               -- 1 = Error, 2 = Warning, 3 = Info, 4 = Hint
    scope = 'workspace',                        -- buffer or workspace
  },
  idle = {
    enable = true,                              -- Enable idle status
    show_status = true,                         -- Display idle status, disable to hide the rich presence on idle
    timeout = 300000,                           -- Timeout in milliseconds after which the idle status is set, 0 to display immediately
    disable_on_focus = false,                   -- Do not display idle status when neovim is focused
    text = 'Idle',                              -- Text to display when idle
    tooltip = '💤',                             -- Text to display when hovering over the idle image
  },
  text = {
    viewing = 'viewing {}',                     -- Text to display when viewing a readonly file
    editing = 'editing {}',                     -- Text to display when editing a file
    -- file_browser = 'Browsing files in {}',      -- Text to display when browsing files (Empty string to disable)
    file_browser = '', 
    plugin_manager = 'managing plugins in {}',  -- Text to display when managing plugins (Empty string to disable)
    lsp_manager = 'configuring LSP in {}',      -- Text to display when managing LSP servers (Empty string to disable)
    vcs = 'committing changes in {}',           -- Text to display when using Git or Git-related plugin (Empty string to disable)
    -- workspace = 'In {}',                        -- Text to display when in a workspace (Empty string to disable)
    workspace = '',                        
  },
  assets = nil,                                 -- Custom file icons, see the wiki*
  -- assets = {
  --   lazy = {                                 -- Vim filetype or file name or file extension = table or string
  --     name = 'Lazy',                         -- Optional override for the icon name, redundant for language types
  --     icon = 'https://example.com/lazy.png', -- Rich Presence asset name or URL
  --     tooltip = 'lazy.nvim',                 -- Text to display when hovering over the icon
  --     type = 2,                              -- 0 = language, 1 = file browser, 2 = plugin manager, 3 = lsp manager, 4 = vcs; defaults to language
  --   },
  --   ['Cargo.toml'] = 'crates',
  -- },
})
END

" lsp stuff...
lua << EOF
local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- install language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {'rust_analyzer', 'ts_ls', 'eslint'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    ['denols'] = function()
      require('lspconfig').denols.setup {
        on_attach = lsp_attach,
        root_dir = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
      }
    end,
    ['ts_ls'] = function()
      require('lspconfig').ts_ls.setup {
        on_attach = lsp_attach,
        root_dir = require('lspconfig.util').root_pattern("package.json"),
        single_file_support = false
      }
    end,
  },
})

-- auto complete
local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate between completion items
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    -- Ctrl+Space to trigger completion menu
    -- this doesn't work...
    ['<M-Space>'] = cmp.mapping.complete(),
    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})
EOF


" KEYBINDS
let mapleader = " " " set leader key to space
nnoremap <leader>l $
vnoremap <leader>l $
nnoremap <leader>h _
vnoremap <leader>h _
nnoremap <leader>j 10j
vnoremap <leader>j 10j
nnoremap <leader>k 10k
vnoremap <leader>k 10k 
" allow option + backspace 
inoremap <M-BS> <C-w>
nnoremap <M-BS> db
vnoremap > >gv
vnoremap < <gv

" nnoremap <D-[> <cmd>e#<cr> "this changes back and forth between 2 files
nnoremap <D-[> <C-o>
nnoremap <D-]> <C-i>

" nnoremap <D-C> :w !pbcopy<CR><CR>
" vnoremap <D-C> :w !pbcopy<CR><CR>

" Telescope 
" nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <D-p> <cmd>Telescope find_files<cr>
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:material_style = 'darker'
colorscheme material

