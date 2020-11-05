#!/bin/bash

# Create the directories for plugins
mkdir -p ~/.vim/pack/vendor/start \
         ~/.vim/autoload \
         ~/.vim/bundle

# Download the Pathogen plugin
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Download the Sensible plugin
git clone https://github.com/tpope/vim-sensible.git \
  ~/.vim/bundle/vim-sensible

# Download the Syntastic plugin
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git \
  ~/.vim/bundle/syntastic

# Download the NERDtree plugin
git clone --depth 1 https://github.com/preservim/nerdtree.git \
	~/.vim/bundle/nerdtree
