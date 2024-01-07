# Initialize keychain
eval $(/usr/bin/keychain --eval --agents ssh --quick --quiet $HOME/.ssh/id_rsa)

# Source the keychain environment for this session
source $HOME/.keychain/$HOSTNAME-sh

[[ -f ~/.bashrc ]] && source ~/.bashrc
