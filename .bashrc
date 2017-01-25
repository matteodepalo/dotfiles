if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

## Fancy prompt
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
black='\[\e[0;30m\]'
BLACK='\[\e[1;30m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
magenta='\[\e[0;35m\]'
MAGENTA='\[\e[1;35m\]'
white='\[\e[0;37m\]'
WHITE='\[\e[1;37m\]'
NC='\[\e[0m\]'

function is_vim_running {
  jobs | grep -o 'vim' &> /dev/null
}

PROMPT_INFO="${BLACK}[\A] ${green}\u${NC} ${BLUE}\w"
PROMPT_RUBY="[\$(rbenv version | sed -e 's/ .*//')]"
PROMPT_GIT="${GREEN}\$(__git_ps1)"
PROMPT_FOOTER="\n\$(is_vim_running && echo \"${red}\" || echo \"${BLACK}\")↳ ${GREEN}\$ ${NC}"

PS1="${PROMPT_INFO} ${PROMPT_RUBY}${PROMPT_GIT} ${PROMPT_FOOTER}"
