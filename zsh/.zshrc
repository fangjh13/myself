# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/fython/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  copypath
  copybuffer
  zsh-autosuggestions
  zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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


# Fython's configuration #
##########################

# CTRL+u same as bash
bindkey \^U backward-kill-line

# fix for navigation keys in JetBrains terminal
if [[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]; then
  bindkey "∫" backward-word # Option-b
  bindkey "ƒ" forward-word # Option-f
  bindkey "∂" delete-word # Option-d
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=/Users/fython/.local/bin:/usr/local/sbin${PATH:+:${PATH}}
export MANPAGER="less -I"

# `pipx` activate completions for zsh need to have bashcompinit enabled in zsh
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

# Initialize the prompt system [https://github.com/sindresorhus/pure]
autoload -U promptinit; promptinit
prompt pure

# less filter use pygments
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

# load my aliases
if [ -e ~/.my-aliases ]
then
    . ~/.my-aliases
fi
     
# active fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --ansi --preview="'"[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -300"'" --preview-window="'"right:hidden:wrap"'" --bind="'"f3:execute(bat --style=numbers {} || less -f {}),ctrl-w:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)"'""
export FD_OPTIONS="--follow --hidden --exclude .git --color=always"
# Use git-ls-files inside git repo, otherwise fd
export FZF_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD --cached --others --exclude-standard || fd --type f --type l ${FD_OPTIONS}"
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="fd ${FD_OPTIONS}"
export FZF_ALT_C_COMMAND="fd --type d ${FD_OPTIONS}"
export FZF_CTRL_R_OPTS="--layout=default"

export BAT_PAGER="less -R"

# display system info
if [[ "$OLDPWD" == "/Users/fython" ]]; then
    neofetch
fi

# Load pyenv automatically
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# golang env
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}"

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
