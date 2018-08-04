# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
}

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# Map jj to ESC
bindkey -M viins 'jj' vi-cmd-mode

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


NORMAL_MODE_INDICATOR="%{$fg[green]%}NORMAL%{$reset_color%}"
# INSERT_MODE_INDICATOR="%{$fg[magenta]%}INSERT%{$fg[black]%}|%{$reset_color%}"

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$NORMAL_MODE_INDICATOR}/(main|viins)/}"
}


function battery_charge {
    echo $(python3 /home/roger/scripts/battery.py -t) 2>/dev/null
}

function battery_color {
    battery_level=$(python3 /home/roger/scripts/battery.py -n)
    if [ $battery_level -ge 6 ]; then
       color="%{$fg[green]%}"
    elif [ $battery_level -eq 5 ]; then
       color="%{$fg[yellow]%}"
    else [ $battery_level -le 4 ]
       color="%{$fg[red]%}"
    fi
    echo ${color}
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '$'
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

PROMPT='%{$fg[magenta]%}%n%{$fg[yellow]%}@%{$fg[red]%}%m%{$reset_color%}:%{$fg[Aqua]%}%~%{$reset_color%}$(git_prompt_info)$(prompt_char)
${ret_status}%{$reset_color%}'

#RPS1='$(vi_mode_prompt_info)$(battery_color)$(battery_charge)%{$reset_color%}'
RPS1='$(vi_mode_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}on git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[red]%}✗ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✓ "


