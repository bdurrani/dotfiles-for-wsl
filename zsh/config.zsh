setopt NO_BG_NICE       # don't nice background tasks

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# shortcut to this dotfiles path is $ZSH
export ZSH_DOTFILES=$HOME/.dotfiles

# all of our zsh files
typeset -U config_files
config_files=($ZSH_DOTFILES/**/*.zsh)

# load everything but the config file since
# it's already loaded
for file in ${config_files:#*/config.zsh}
do
  source $file
done

unset config_files
