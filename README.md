# Dotfiles do Pedro

Esse repositório armazena todos os dotfiles que uso no meu ambiente unix-like :pray:.  

## Como funciona

Os arquivos que vão para o `$HOME` ficam em `home/` e são aplicados com [chezmoi](https://www.chezmoi.io/) (o `.chezmoiroot` aponta para essa pasta). O resto do repositório (`scripts/`, `secrets/`, `tests/`, ...) não é copiado.

```sh
chezmoi init --source ~/workspace/personal/dotfiles --apply   # primeira vez (ou: make apply)
chezmoi diff     # o que mudaria no $HOME
chezmoi apply    # aplica
make test        # testes em bats (brew install bats-core)
```

- Configs só do Linux (sway, foot, input-remapper) são ignoradas no macOS (`home/.chezmoiignore`).
- As cheatsheets da comunidade do `cheat` são baixadas pelo `home/.chezmoiexternal.toml`.
