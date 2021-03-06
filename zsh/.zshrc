# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

export EDITOR="vim"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby osx brew cake gem npm xcode tmux terminalapp)

export PATH=/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:/usr/X11/bin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:/Applications/Postgres.app/Contents/MacOS/bin #postgres
export PATH=$PATH:/usr/local/bin/Sencha/Cmd/4.0.4.84
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH # npm with homebrew
export PATH=$PATH:/usr/local/lib
export PATH=$PATH:$HOME/bin
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Projects/go
export PATH=$PATH:$GOPATH/bin
export ZSH_CUSTOM=$HOME/.zsh-custom
export PATH=$PATH:/Applications/Android\ Studio.app/sdk/platform-tools:/Applications/Android\ Studio.app/sdk/tools
export PATH="$HOME/Library/Haskell/bin:$PATH"

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/X11/lib/pkgconfig

source $ZSH/oh-my-zsh.sh

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# Parse out version from xcodebuild's plist based on output of xcode-select
# Thanks to @danielpunkass for the performance improvement that avoids executing "xcodebuild -version"
# http://marcpalmer.net/hacking-my-shell-prompt-so-i-make-less-mistakes-working-with-xcode-projects/
function parse_xcode_version {
    echo `plutil -p \`xcode-select -p\`/../Info.plist | grep -e CFBundleShortVersionString | sed 's/[^0-9\.]*//g'`
}

PROMPT=$'%{$fg[blue]%}$(collapse_pwd)%{$reset_color%} $(parse_xcode_version) $(git_prompt_info)$(virtualenv_info) $(prompt_char)\n%{$fg[yellow]%}❯ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export PRO_BASE=$HOME/Projects/

# pro cd function
pd() {
  local projDir=$(pro search $1)
  cd ${projDir}
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Makes GPG work correctly with Keybase's verification command (which otherwise fails to ask for a passphrase)
export GPG_TTY=`tty`

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z


export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
