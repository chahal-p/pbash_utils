# Installation
  1. Install pflags from https://github.com/chahal-p/pflags
  1. Download a version from https://github.com/chahal-p/pbash_utils/releases
  1. Unzip the file
  1. Navigate to extracted directory
     ```sh
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
