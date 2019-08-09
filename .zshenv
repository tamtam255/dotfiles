# export PATH=~/bin:"$PATH"

# if [[ -z $DOTPATH ]]; then
#     _get_dotpath() {
#         local d
#         d="${0:A:h}"
#         if [[ $d =~ dotfiles$ ]]; then
#             echo "$d"
#         else
#             return 1
#         fi
#     }
#     export DOTPATH="$(_get_dotpath)"
#     unfunction _get_dotpath
# fi

# History file and its size
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# export DOTPATH=${0:A:h}
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles; export DOTPATH
fi
