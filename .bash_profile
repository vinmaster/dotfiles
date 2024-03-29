
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

HISTSIZE=100000
HISTFILESIZE=100000
# No duplicate entries
#export HISTCONTROL=ignoredups:erasedups
# ignoreboth = ignoredups + ignorespace
export HISTCONTROL=ignoreboth

# Opposite of Ctrl-R
bind "\C-t":forward-search-history

# Use vi
export EDITOR=vi

# Allow branch name to be shown in terminal
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
# export PS1="\T \u@\W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export PS1="\T \W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

#export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
