local fn = vim.fn
local installPath = DATA_PATH..'/site/pack/packer/start/packer.nvim'

-- install packer if it's not installed already
local packerBootstrap = nil
if fn.empty(fn.glob(installPath)) > 0 then
  packerBootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', installPath})
  vim.cmd [[packadd packer.nvim]]
end

local packer = require('packer').startup(function(use)
    -- Packer should manage itself
  use 'wbthomason/packer.nvim'

  use 'yonikosiner/todo-me-daddy'

  use {"xiyaowong/nvim-transparent"}
    -- colorscheme
  use 'folke/tokyonight.nvim'

  use {"folke/trouble.nvim"}

  use {"mhartington/formatter.nvim"}
    -- git integration
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      }
    }

  -- Dashboard
  use { "glepnir/dashboard-nvim" }

  -- surround vim
  use 'tpope/vim-surround'

  -- nerd commenter
  use 'scrooloose/nerdcommenter'

  -- status line
  use 'glepnir/galaxyline.nvim'

  -- discord presence
  use 'andweeb/presence.nvim'
  -- show recent files on empty nvim command
  use 'mhinz/vim-startify'

  -- lsp config
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
        {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"},
        {"hrsh7th/cmp-cmdline"}, {"hrsh7th/cmp-vsnip"},
        {"f3fora/cmp-spell", {"hrsh7th/cmp-calc"}}
    },
  }

  -- For vsnip users.
  use 'hrsh7th/vim-vsnip'

  -- telescope - searching / navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { "sbdchd/neoformat" }

  use {"ray-x/lsp_signature.nvim", requires = {{"neovim/nvim-lspconfig"}}}

  -- better hotfix window (for showing and searching through results in telescope's find usages)
  use {"kevinhwang91/nvim-bqf"}

  -- better highlighting
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  use {"akinsho/nvim-toggleterm.lua"}

  use {"voldikss/vim-floaterm"}

  use {"onsails/lspkind-nvim", requires = {{"famiu/bufdelete.nvim"}}}

  use {"windwp/nvim-autopairs"}

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }

  -- prettier tabs
  use 'romgrk/barbar.nvim'

  -- nice diagnostic pane on the bottom
  use 'folke/lsp-trouble.nvim'

  -- support the missing lsp diagnostic colors
  use 'folke/lsp-colors.nvim'

  -- better LSP UI (for code actions, rename etc.)
  use 'tami5/lspsaga.nvim'

  -- show indentation levels
  use 'lukas-reineke/indent-blankline.nvim'

  -- this will automatically install listed dependencies
  -- only the first time NeoVim is opened, because that's when Packer gets installed
  if packerBootstrap then
    require('packer').sync()
  end
end)

-- plugin specific configs go here
require('plugin-config/telescope')
require('plugin-config/nvim-tree')
require('plugin-config/nvim-treesitter')
require('plugin-config/barbar')
require('plugin-config/lsp-colors')
require('plugin-config/lsp-trouble')
require('plugin-config/lspsaga')
require('plugin-config/galaxyline')
require('plugin-config/gitsigns')
require('plugin-config/indent-guide-lines')
require('plugin-config/transparent')
require('plugin-config/toggleterm')
require('plugin-config/trouble')
require('plugin-config/formatter')
require('plugin-config/cmp')
require('plugin-config/autopairs')
require('plugin-config/dashboard-nvim')
require('plugin-config/presence')
require('plugin-config/todo-me-daddy')

return packer
