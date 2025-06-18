# Installation
  1. Install pflags from https://github.com/chahal-p/pflags
  1. Clone git repo
     ```sh
     git clone https://github.com/parveenchahal/pbash_utils.git
     ```
  1. ```sh
     cd pbash_utils
     chmod +x install.sh
     ```
  1. ```sh
     ./install.sh --install all
     ```
  1. Add below to .bashrc
     ```
     [[ ":$PATH:" == *":$HOME/.local/bin:"* ]] || export PATH="$PATH:$HOME/.local/bin"
     source pbu_init.sh
     ```
