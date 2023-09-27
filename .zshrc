export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# should add /usr/local/bin?

HISTSIZE=100000
HISTFILESIZE=${HISTSIZE}
# No duplicate entries
#export HISTCONTROL=ignoredups:erasedups
# ignoreboth = ignoredups + ignorespace
export HISTCONTROL=ignoreboth
# Record timestamp
setopt extended_history
# To save every command before it is executed (this is different from bash's history -a solution):
setopt inc_append_history
# Ignore commands start with space
setopt histignorespace
# Ignore dups of previous event
setopt hist_ignore_dups
# Hit Enter when using bang-history
setopt hist_verify
# To read the history file everytime history is called upon as well as the functionality from inc_append_history. Don't use together
#setopt share_history

# bind hstr-rs to CTRL + H
# bindkey -s '^H' 'hstr-rs^M'

source ~/.zsh/git-prompt.zsh/git-prompt.zsh
ZSH_GIT_PROMPT_SHOW_UPSTREAM="no"
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="] "
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}⟳ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"
# %~ is path from home. Number after % is how many dir
# PROMPT='%F{green}%*%f %F{blue}%1~%f %B$(gitprompt)%b$ '
PROMPT='%F{blue}%1~%f %B$(gitprompt)%b$ '
#PROMPT+='%(?.%(!.%F{white}❯%F{yellow}❯%F{red}.%F{blue}❯%F{cyan}❯%F{green})❯%f.%F{red}❯❯❯%f) '

# Fix iterm2 tab name not changing after exit ssh
# export PROMPT_COMMAND="printf '\e]0;\7'"

# Enable git completion
autoload -Uz compinit && compinit

# Edit the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# FZF show history using ctrl-r
#export FZF_DEFAULT_OPTS='--border'
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}
# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

# Add command execution time after each command
# setopt prompt_subst?
# Needed brew install coreutils
function preexec() {
  # timer=$(($(gdate +%s%0N)/1000000))
  timer=$(($(gdate +%s%0N)/1000000000))
}

function precmd() {
  if [ $timer ]; then
    # now=$(($(gdate +%s%0N)/1000000))
    now=$(($(gdate +%s%0N)/1000000000))
    elapsed=$(($now-$timer))

    # export RPROMPT="%F{cyan}${elapsed}ms%{$reset_color%}"
    # Add timestamp $(date "+%F %T %z") = full timestamp
    # export RPROMPT="%F{cyan}${elapsed}s %F{green}$(date "+%T")%{$reset_color%}"

    # Update to show minutes and seconds
    if [[ elapsed -gt 60 ]] then
      elapsed2=$(printf '%2dm:%02ds\n' $((elapsed%3600/60)) $((elapsed%60)))
    else
      elapsed2=$(printf '%2ds\n' elapsed)
    fi
    export RPROMPT="%F{cyan}${elapsed2} %F{green}$(date "+%T")%{$reset_color%}"
    unset timer
  fi
}

javahome() {
  unset JAVA_HOME
  export JAVA_HOME=$(/usr/libexec/java_home -v "$1");
  java -version
}

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.flutter/flutter/bin
export PATH=$PATH:$HOME/.cargo/bin

