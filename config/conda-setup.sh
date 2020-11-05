#!/bin/bash

# Download miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3.sh

# Install to home
bash ~/miniconda.sh -b -p $HOME/miniconda3

# Setup bash shell
eval "$(~/miniconda3/bin/conda shell.bash hook)"
conda init bash

# Disable base environment activation
conda config --set auto_activate_base false
