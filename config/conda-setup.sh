#!/bin/bash

# Download miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3.sh

# Install to home
bash ~/miniconda3.sh -b -p $HOME/miniconda3

# Setup bash shell
eval "$(~/miniconda3/bin/conda shell.`basename $SHELL` hook)"
conda init bash

# Disable base environment activation
conda config --set auto_activate_base false

# Install utilities
yes | conda install -c conda-forge mamba=0.6.4 conda-merge=0.1.5

# Add conda-merge to path
echo 'alias conda-merge="~/miniconda3/bin/conda-merge"' >> ~/.`basename $SHELL`rc
source ~/.`basename $SHELL`rc
