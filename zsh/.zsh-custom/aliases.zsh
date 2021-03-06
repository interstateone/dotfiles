alias ls='ls -Glah'
alias l='ls -GlA1'
alias ll='ls -Gl'
alias la='ls -GlA'
alias gho="git config --get remote.origin.url | ruby -ne 'puts %{https://github.com/#{\$_.split(/.com[\:\/]/)[-1].gsub(\".git\",\"\")}}' | xargs open"
alias gpf="git push --force-with-lease"
alias gfp="git fetch --prune"
alias gupdate="gco master && gup && gfp && gbda"
alias grbm="gco master; gup; gco -; grb master"

alias gbi='hub browse -- issues'
alias gbpr='hub browse -- pulls'
alias pr='hub pull-request'

alias pi='pod install'
alias pu='pod update'

alias t='tig'
alias tr='tig refs'
alias ts='tig status'
alias ta='tig --all'

alias zshconfig="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

alias tmux="tmux -2"
alias cleanup="git branch --merged | xargs git branch -d"

alias rake='noglob rake'

alias top='htop'

alias stow='stow --ignore=.DS_Store'

alias r='ranger'
alias n='ncmpcpp'

alias re='remind -l Reminders'

alias cdf='cd "`pwdf`"'

alias f='fzf --height=30 --reverse'
alias vf='vim "$(fzf)"'

alias xcpick='xcodes select'
