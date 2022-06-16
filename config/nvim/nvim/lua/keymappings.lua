-- defaults
local opts = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

-- NvimTreeToggle
map('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})


-- shift the movement keys by 0 to the right
map('', 'j', 'h', opts)
map('', 'k', 'j', opts)
map('', 'l', 'k', opts)
map('', 'ç', 'l', opts)

-- Trouble Toggle (Space + x x)
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})

-- Toggle Terminal (F9)
map("n", "<F9>", "<cmd>FloatermToggle<cr>", { silent = true })
map("t", "<F9>", "<cmd>FloatermToggle<cr>", { silent = true })

-- Navigate between float terminals (Space + , | Space + .)
map("t", "<leader>.", "<cmd>FloatermNext<cr>", { silent = true })
map("t", "<leader>,", "<cmd>FloatermPrev<cr>", { silent = true })
-- Save File (CTRL + S)
map("n", "<C-s>", "<cmd>write<cr>", { silent = true })
-- New terminal / Kill terminal
map("n", "<leader>nt", "<cmd>FloatermNew<cr>", { silent = true })
map("t", "<leader>nt", "<cmd>FloatermNew<cr>", { silent = true })
map("n", "<leader>kt", "<cmd>FloatermKill<cr>", { silent = true })
map("t", "<leader>kt", "<cmd>FloatermKill<cr>", { silent = true })

-- Close current buffer
map("n", "<leader>bd", "<cmd>:bd<cr>", { silent = true })

-- Todo Daddy
map("n", "<leader>td", "<cmd>:lua require('telescope').extensions.todo_me_daddy.todos()<cr>", { silent = true })
map("n", "<leader>tm", "<cmd>:lua require('telescope').extensions.todo_me_daddy.your_todos()<cr>", { silent = true })
map("n", "<leader>m", "<cmd>:lua require('todo-me-daddy').complete_markdown_todo()<cr>", { silent = true })

-- Back to ESC (jk)
map('i', 'jk', '<ESC>', {noremap = true, silent = false})
map('i', 'kj', '<ESC>', {noremap = true, silent = false})

-- mapping ESC to ć
map('n', 'ć', '<Esc>', opts)
map('n', 'Ć', '<Esc>', opts)
map('v', 'ć', '<Esc>', opts)
map('v', 'Ć', '<Esc>', opts)
map('c', 'ć', '<Esc>', opts)
map('c', 'Ć', '<Esc>', opts)
-- make the cursor stay on the same character when leaving insert mode
map('i', 'ć', '<Esc>l', opts)
map('i', 'Ć', '<Esc>l', opts)

-- fast scrolling
map('n', 'K', '9j', opts)
map('n', 'L', '9k', opts)
map('v', 'K', '9j', opts)
map('v', 'L', '9k', opts)

-- stay in normal mode after inserting a new line
map('', 'o', 'o <Bs><Esc>', opts)
map('', 'O', 'O <Bs><Esc>', opts)

-- mapping that opens .vimrc in a new tab for quick editing
map('n', '<Leader>ev', '<Cmd>tabe $MYVIMRC<CR>', opts)
-- mapping that sources the vimrc in the current filea doesn't work, should change all require calls to dofile
-- or clear all require cache and reimport
-- map('n', '<Leader>sv', '<Cmd>lua dofile(vim.fn.stdpath(\'config\')..\'/init.lua\')<CR>', { noremap = true, silent = false })

-- Mapping U to Redo.
map('', 'U', '<C-r>', opts)
map('', '<C-r>', '<NOP>', opts)

-- indent via Tab
-- map('n', '<Tab>', '>>_', opts)
-- map('n', '<S-Tab>', '<<_', opts)
-- map('v', '<Tab>', '>>_', opts)
-- map('v', '<S-Tab>', '<<_', opts)

-- window movement
map('', '<C-w>j', '<C-w>h', opts)
map('', '<C-w>k', '<C-w>j', opts)
map('', '<C-w>l', '<C-w>k', opts)
map('', '<C-w>ç', '<C-w>l', opts)


-- jumping back and forth
map('', '<C-K>', '<C-O>', opts)
map('', '<C-L>', '<C-I>', opts)

-- LSP
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', 'gf', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
-- usages replaced by LspSaga plugin
-- map('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- eg. autoimport
-- map('n', 'gn', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- map('n', 'gN', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- map('n', '<leader>hg', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- map('n', '<leader>gr', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)

-- Navigate file tabs (, and . )
map("n", '<A-,>', "<cmd>:bp<cr>", { silent = true })
map("n", '<A-.>', "<cmd>:bn<cr>", { silent = true })


map('n', '<leader>ww', "<cmd>:set wrap!<cr>", { silent = true })
-- autocomplete
-- if autocomplete popup menu opens pressing enter will complete the first match
-- map('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
map('i', '<CR>', 'pumvisible() ? "<C-n><Esc>a" : "<CR>"', {expr = true, noremap = true, silent = true})

-- Neoformat
map("n", '<leader>fo', "<cmd>:Neoformat<cr>", { silent = true })
