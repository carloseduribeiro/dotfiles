# nvim

## Configuração inicial

Clonar essa pasta dentro da pasta ```.config``` do seu usuário, abrir o NeoVim e executar esse comando:

```:MasonInstallAll``` para instalar todos os plugins.

## Links Úteis:

https://github.com/NvChad/NvChad  
https://pkg.go.dev/golang.org/x/tools/gopls  
https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md  
https://github.com/jose-elias-alvarez/null-ls.nvim  
https://github.com/go-delve/delve  

## Atalhos Importantes:

```'<leader>th'```    exibe a lista de temas

### Debuging
```'<leader>db'```      add breakpoint  
```'<leader>dgt'```     Debug go test  
```'<leader>dgl'```     Debug last go test  

### Golang Development:
```'<leader>gsj'```     add json struct tags  
```'<leader>gsy```      add yaml struct tags  

## Golang comands:

```:GoTagAdd json```    adiciona as tags json na struct onde o cursos está situado.  
```:GoIfErr```          adiciona a verificação de erro  
```:GoMod tity```  
```:GoGet package```  
```:GoTestsAll```       gera testes baseado em um boilerplate  

Mais info.: https://github.com/olexsmir/gopher.nvim
