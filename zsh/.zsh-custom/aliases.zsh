alias ls='ls -Glah'
alias l='ls -GlA1'
alias ll='ls -Gl'
alias la='ls -GlA'
alias gf='git fetch'
alias gfp='git fetch --prune'
alias gp='git push'
alias gc='git checkout'
alias gcn='git checkout -b'
alias grb='git rebase'
alias gho="git config --get remote.origin.url | ruby -ne 'puts %{https://github.com/#{\$_.split(/.com[\:\/]/)[-1].gsub(\".git\",\"\")}}' | xargs open"
alias gca="git commit --amend --no-edit"

alias pr='hub pull-request'

alias pi='pod install'
alias pu='pod update'

alias tiga='tig --all'

alias zshconfig="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

alias tmux="tmux -2"
alias cleanup="git branch --merged | xargs git branch -d"

alias rake='noglob rake'

alias gpg='gpg2'

alias htop='sudo htop'

alias stow='stow --ignore=.DS_Store'
