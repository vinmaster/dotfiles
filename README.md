# dotfiles

## Installation
```bash
curl https://raw.github.com/vinmaster/dotfiles/master/install.sh -L -o - | sh

```

### .bashrc
```bash
. /usr/share/autojump/autojump.sh

up() { local p= i=${1:-1}; while (( i-- )); do p+=../; done; cd "$p$2" && pwd; }
```
