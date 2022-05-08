#
#
#
# If not running interactively, don't do anything
[[ -o interactive ]] || return

# There configs should be set before p10k instant prompt
stty stop undef
export GPG_TTY=$(tty)


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# If you come from bash you might have to change your $PATH.
#
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
#
# # Path to your oh-my-zsh installation.
#export ZSH="/home/soohyun/.oh-my-zsh"
#
# Set name of the theme to load --- if set to "random", it will
#
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#
#ZSH_THEME="powerlevel10k/powerlevel10k"


# Which plugins would you like to load?
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
#
# # Add wisely, as too many plugins slow down shell startup.
plugins=(git)
#


#
#
#
# zinit
#
autoload -U is-at-least
if is-at-least 5.1 && [[ -d ~/.zinit ]]; then

  source ~/.zinit/bin/zinit.zsh
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  zplugin ice depth=1
  zplugin light romkatv/powerlevel10k

  # Show autosuggestions
  ZSH_AUTOSUGGEST_USE_ASYNC=1


  if is-at-least 5.3; then
    zinit ice silent wait'1' atload'_zsh_autosuggest_start'

  fi

  zinit light zsh-users/zsh-autosuggestions

  # Easily access the directories you visit most often.
  #
  # Usage:
  #   $ z work
  #   $ <CTRL-G>work
  zinit light agkozak/zsh-z

  zinit light andrewferrier/fzf-z
  export FZFZ_SUBDIR_LIMIT=0

  #
  # Automatically expand all aliases
  ZSH_EXPAND_ALL_DISABLE=word
  zinit light simnalamburt/zsh-expand-all

  # Others
  zinit light zdharma/fast-syntax-highlighting
  zinit light zsh-users/zsh-history-substring-search

  zinit light zsh-users/zsh-completions

  autoload -Uz compinit
  compinit
  zinit cdreplay


  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down


else
  # Default terminal
  case "$TERM" in
    xterm-color|*-256color)
      PS1=$'\e[1;32m%n@%m\e[0m:\e[1;34m%~\e[0m%(!.#.$) ';;
    *)
      PS1='%n@%m:%~%(!.#.$) ';;
  esac

  autoload -Uz compinit
  compinit

fi

#
#
#
# lscolors
#
# autoload -U colors && colors
# export LSCOLORS="Gxfxcxdxbxegedxbagxcad"
# export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=30;46:tw=0;42:ow=30;43"
# export TIME_STYLE='long-iso'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# set JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v1.8)
#export JAVA_HOME="`/usr/libexec/java_home -v '1.8.0_322'`"

#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
PATH="/usr/local/bin:$PATH"

alias ls='ls -G'
# alias ls='exa'

# alias for company ssh
alias dgw02='ssh soohyunlee@dgw02.navercorp.com'
alias ncon1='ssh soohyunlee@ncon1.navercorp.com' 

source ~/powerlevel10k/powerlevel10k.zsh-theme

. /opt/homebrew/opt/asdf/libexec/asdf.sh

alias pyspark=~/spark/bin/pyspark

# pyspark
#
export PATH=$PATH:~/.asdf/installs/python/3.10.2/bin/
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
