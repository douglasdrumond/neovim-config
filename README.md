# neovim-config

## Pre-reqs

First, install [Packer](https://github.com/wbthomason/packer.nvim)

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Install language servers
```
npm i -g vscode-langservers-extracted
npm install -g typescript typescript-language-server
```

## Post-install

1. Inside Neovim, run `:PackerCompile` and `:PackerInstall`.
2. Restart Neovim.
3. Run `:Copilot setup`.

## Troubleshoot

### Nodejs
```
asdf install nodejs 17.1.0
asdf global nodejs 17.1.0
```
