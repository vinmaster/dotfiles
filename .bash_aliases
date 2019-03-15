alias ls='ls -GF'
alias ll='ls -laGF'
alias lrth='ls -lrth' # Last modified
alias l.='ls -dG .*'  # List dot files/folders
alias ls-folder='ls -d -- */' # List folders only
alias mv='mv -i'
alias cp='cp -i'
alias tree='tree -I ".git|node_modules" -aC'
alias findpid="ps axww -o pid,user,%cpu,%mem,start,time,command | fzf | sed 's/^ *//' | cut -f1 -d' '"
alias compose='docker-compose'
alias journal='mkdir -p ~/journal/$(date +%Y); vim +:e "~/journal/$(date +%Y)/$(date +%Y-%m-%d).md" +"r!date";'
alias tar-compress='tar -czvf'
alias tar-extract='tar -xzvf'
alias ssh-status='sudo systemsetup -getremotelogin'
alias ssh-set='sudo systemsetup -setremotelogin ' # 'off' or 'on'
alias flushdns='dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias keyrepeat-on='defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false'
alias show-hidden='defaults write com.apple.finder AppleShowAllFiles -boolean true ; killall Finder'
alias hide-hidden='defaults write com.apple.finder AppleShowAllFiles -boolean false ; killall Finder'
alias project='cd $(find ~/code/projects -maxdepth 1 -type d | fzf)'
alias pickcd='cd $(find . -maxdepth 1 -type d | fzf)'
alias runfzf='run $(printf "%s\n" "${_run_list[@]}" | fzf)'
alias renew-ip="sudo ipconfig set en0 BOOTP && sudo ipconfig set en0 DHCP"
alias script-record="script -r"
alias script-playback="script -p"
alias restart-audio="sudo killall coreaudiod"
alias change-modified-date="touch -mt $(date '+%Y%m%d%H%M')"

# Functions as commands
up() { local p= i=${1:-1}; while (( i-- )); do p+=../; done; cd "$p$2" && pwd; }
ram() { local search=$1; echo $search; ps -eo pmem,comm | grep -i $search | awk '{sum+=$1} END {print sum " % of RAM"}'; }
fswatchrun() { echo "Watching $1 and running command '$2'"; fswatch [opts] -0 $1 | xargs -0 -n1 -I{} $2; }
#chokidar-run() { chokidar-cmd -t '*' -c "$1"; }
#chokidar-run() { chokidar "*" -c "$1"; }
switch-profile() { echo -e "\033]50;SetProfile=$1\a"; }
taskdone() { terminal-notifier -message $1; }
loc() { find . -name '*.$1' | xargs wc -l; }
findfile() { find . | ag $1; }
mdfind-file() { mdfind $1 -onlyin ${2:-.} ; }
findfolder() {
  # findfolder "SEARCH STRING" DEPTH
  if [[ -z "$2" ]]; then
    depth=1
    find . -type d -name "*$1*" -print
  #elif [[ -z "$2" ]]; then
  else
    depth="$2"
    find . -maxdepth $depth -type d -name "*$1*" -print
  fi
}
findonefolder() { find . -maxdepth 1 -type d -name "*$1*" -print -quit; }
findport() { lsof -wni tcp:$1; }
findprocess() { lsof $1; }
global-find() { sudo find / -name "$1" -print; }
gitchurn() {
  git log --all -M -C --name-only --format='format:' "$@" | sort | grep -v '^$' | uniq -c | sort -n | awk 'BEGIN {print "count\tfile"} {print $1 "\t" $2}';
}
word-frequency() {
  #!/usr/bin/env bash
  ruby -F'[^a-zA-Z0-9]+' -ane '
      BEGIN   { $words = Hash.new(0) }
      $F.each { |word| $words[word.downcase] += 1 }
      END     { $words.each { |word, i| printf "%3d %s\n", i, word } }
  ' |
  sort -rn;
}
die() {
  echo >&2 "$@"
  exit 1
}
work() {
  if [ "$#" -ne 1 ]
  then
    echo "Changed to ~/work"
    cd ~/work
  else
    echo "Changed to $1"
    cd ~/work/$1
  fi
}
_work_complete() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -S/ -d ~/work/$cur | cut -b 21- ) )
}
complete -o nospace -F _work_complete work
hist() { history | tail -r -n 30 | awk '{$1 = ""; print $0;}' | awk '{$1=$1};1' | fzf | bash; }

# Auto Complete
_run_list=(
"rails s -b 0.0.0.0"
"source ~/.bash_aliases"
"source ~/.bash_profile"
"source ~/.bashrc"
)
_run()
{
	local cur prev i run_list_escaped match_list match_string
  # Set Internal Field Separator to newline
  local IFS=$'\n'
	# Variable storing possible completions
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	# prev=${COMP_WORDS[COMP_CWORD-1]}

  match_list=()
  run_list_escaped=()
  # # Remove the part already present in $cur
  # for ((i = 0; i < ${#_run_list[@]}; i++)) do
  #   run_list_escaped[i]=$( echo "${_run_list[$i]}" | sed -e "s/ /\\ /g" )
  # done
	# run_list_escaped=$_run_list
	# echo "list $run_list_escaped"
	# # return
  # # If one of the command is part of COMP_WORDS after index 1. Star matches string after
  # for ((i = 0; i < ${#run_list_escaped[@]}; i++)) do
  #   if [[ "${run_list_escaped[$i]}" == ${COMP_WORDS[@]:1}*  ]] ; then
  #     match_list+=("${run_list_escaped[$i]}")
  #   fi
  # done
	#
  # # Reduce array into string
  # match_string=$''
  # for i in "${match_list[@]}"; do
  #   match_string+=$i$'\n';
  # done
	#
  # COMPREPLY=( $(echo "$match_string") )
  # # COMPREPLY=$match_list

	# With forward slash
	match_list=($(compgen -W "${_run_list[*]}" -- "$cur"))
	if [ ${#match_list[*]} -eq 0 ]; then
		COMPREPLY=()
	else
		COMPREPLY=($(printf '%q\n' "${match_list[@]}"))
	fi
  return 0
}
#COMPREPLY: is an array variable from which Bash reads the possible completions.
#COMP_WORDS: an array of all the words typed after the name of the program the compspec belongs to
#COMP_CWORD: an index of the COMP_WORDS array pointing to the word the current cursor is at - in other words, the index of the word the cursor was when the tab key was pressed
#COMP_LINE: the current command line
#compgen -W "--help --verbose --version" -- "<userinput>" This command returns the array of elements from --help, --verbose and --version matching the current word "${cur}"
# complete -o nospace -F _run run
complete -F _run run
#complete -o nospace -W "${_run_list}" 'run'
