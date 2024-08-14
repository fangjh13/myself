# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.oh-my-zsh/custom

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-history-substring-search
  zsh-autosuggestions
  copypath
  copybuffer
)

# add additional completion definitions for Zsh.
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
# [pure](https://github.com/sindresorhus/pure)
fpath+=(${ZSH_CUSTOM}/pure)

source $ZSH/oh-my-zsh.sh

# Initialize the prompt system
autoload -U promptinit; promptinit
prompt pure

# zsh-history-substring-search bind keyboard shortcuts 
# https://github.com/zsh-users/zsh-history-substring-search#zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey '^[OA' history-substring-search-up     # 
bindkey '^[OB' history-substring-search-down   # 

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# user configuration
bindkey \^U backward-kill-line # Ctrl-w kill a word
unix-word-rubout() {
  local WORDCHARS=$'!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
  zle backward-kill-word
}
zle -N unix-word-rubout
bindkey '^H' unix-word-rubout # Ctrl-delete kill from cursor to space, can use `showkey -a` find key
# macos need rebind
if [[ "$OSTYPE" == "darwin"* ]]; then
  bindkey '<CTL-H=BS>' unix-word-rubout
fi

# ----- fzf && fd -----
# active fzf
if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  _copy_command="pbcopy"
else
  # first run `sudo pacman -S fzf fd`
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
  [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
  # wayland
  if [ -n "$WAYLAND_DISPLAY" ]; then
      _copy_command="wl-copy"
  else
    # X window clipboard
      _copy_command="xclip -sel clip"
  fi
fi
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --ansi --preview='[[ -d {} ]] && eza --tree --color=always {} || ([[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file) || (bat --style=numbers --color=always --line-range=:500 {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),ctrl-w:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | $_copy_command)'"
FD_OPTIONS="--follow --hidden --exclude .git --color=always"
# Use git-ls-files inside git repo, otherwise fd
export FZF_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD --cached --others --exclude-standard || fd --type f --type l ${FD_OPTIONS}"
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="fd ${FD_OPTIONS}"
export FZF_ALT_C_COMMAND="fd --type d ${FD_OPTIONS}"
export FZF_CTRL_R_OPTS="--layout=default"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# fzf-git (https://github.com/junegunn/fzf-git.sh)
source ~/.oh-my-zsh/custom/fzf-git.sh/fzf-git.sh

# smarter cd command `z` (https://github.com/ajeetdsouza/zoxide)
eval "$(zoxide init zsh)"

# my personal aliases
if [ -e ~/.my-aliases ]
then
    . ~/.my-aliases
fi

# less filter use pygments
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
export BAT_PAGER="less -R"

# pyenv bin environment
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH:+:${PATH}}"
eval "$(pyenv init -)"
# install pyenv-virtualenv, enable auto-activation of virtualenvs
eval "$(pyenv virtualenv-init -)"

# go bin path
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX
  export GOPATH=$HOME/go
  export GOROOT="$(brew --prefix golang)/libexec"
  export PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}"
else
  export PATH="${HOME}/go/bin:${PATH:+:${PATH}}"
fi

# rust cargo
export PATH="${HOME}/.cargo/bin:${PATH:+:${PATH}}"

# `pipx` activate completions for zsh need to have bashcompinit enabled in zsh
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

# Conda initialize
# !! Contents within this block are managed by 'conda init' !!
function conda_activate {
    __conda_setup="$('${HOME}/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
            . "${HOME}/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="${HOME}/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

# Node Version Manager
# maual install https://github.com/nvm-sh/nvm?tab=readme-ov-file#git-install
function nvm_activate {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # Calling `nvm use` automatically in a directory with a .nvmrc file
    # place this after nvm initialization!
    autoload -U add-zsh-hook
    
    load-nvmrc() {
      local nvmrc_path
      nvmrc_path="$(nvm_find_nvmrc)"
    
      if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version
        nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    
        if [ "$nvmrc_node_version" = "N/A" ]; then
          nvm install
        elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
          nvm use
        fi
      elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
      fi
    }
    
    add-zsh-hook chpwd load-nvmrc
    load-nvmrc
}

# swith different JDK versions
# Arch can use `archlinux-java` script
# function jdk {
#     home=/usr/libexec/java_home
#     version=$1
#     if [[ $# -eq 0 ]]; then
#         ${home} -V
#     else
#         export JAVA_HOME=$("${home}" -v "${version}")
#         java -version
#     fi
# }


