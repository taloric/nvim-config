# nvim-config

Lately I found vscode-vim is very slow during big page switches (over 3000 lines), so I tried vscode-neovim and it solve my problems, because technically vscode-vim is a vim simulator but vscode-neovim would try to interact with neovim process, that's the main difference, also, in neovim I can add a lot of custom configs to improve my coding experience and it seems great. Record here for what I've done with it.

## Plugins

### Plugin Management

plugin management: [lazy](https://github.com/folke/lazy.nvim)

### Lsp & Editor

lsp related plugins manage: [mason](https://github.com/williamboman/mason.nvim)

lspconfig for mason & mason-lspconfig: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

code formatter: [conform](https://github.com/stevearc/conform.nvim)

code syntax tree analysis: [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

golang supported: [go.nvim](https://github.com/ray-x/go.nvim)

### Completion

input completion: [nvim-cmp](http://github.com/hrsh7th/nvim-cmp)

### Session

session persistence: [persistence](https://github.com/folke/persistence.nvim)

no need now but it seems useful when using tmux: integrated with terminals: [Navigator](https://github.com/numToStr/Navigator.nvim)

copy & paste supported when use ssh connected to vms: [smartyank](https://github.com/ibhagwan/smartyank.nvim)

### UI

windows switch & buffer view: [bufferline](https://github.com/akinsho/bufferline.nvim)

vscode like theme: [vscode](https://github.com/Mofiqul/vscode.nvim)

file explorer: [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)

status line: [mini statusline](https://github.com/echasnovski/mini.statusline)

code indent line: [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)

### File Searcher

file search & keyword grep: [telescope](https://github.com/nvim-telescope/telescope.nvim)

### KeyMapping

view key mappings: [which-key](https://github.com/folke/which-key.nvim)

### VsCode Supported

vscode multi cursor supported(highly recommend): [vscode-multi-cursor](https://github.com/vscode-neovim/vscode-multi-cursor.nvim)

### Chinese Supported

supported words split and jump by keys like 'b/w/e': [jieba.nvim](https://github.com/noearc/jieba.nvim)

