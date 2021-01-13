#!/bin/bash

# Check if $HOME/bin has already been set
bin_res=`grep "PATH.*\($HOME/bin\)" ~/.bashrc`

# If not in PATH
if [[ -z ${bin_res} ]]; 
then 
	  echo "Creating and adding $HOME/bin to PATH" \
		&& mkdir -p $HOME/bin \
		&& echo "export PATH=$HOME/bin:\$PATH" >> ~/.bashrc \
		&& export PATH=$HOME/bin:$PATH \
		&& echo $PATH;
fi

# Download zsh
echo "Downloading zsh..."
cd $HOME
wget -O ~/zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download

# Unpack zsh
echo "Unpacking zsh..."
mkdir zsh && tar -xvf zsh.tar.gz -C zsh --strip-components 1

# Install zsh
echo "Installing zsh..."
cd zsh
./configure --prefix=$HOME
make
make install

# Download oh-my-zsh
echo "Downloading oh-my-zsh..."
cd $HOME
wget ~/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

# Install oh-my-zsh
echo "Installing oh-my-zsh..."
bash ~/install.sh

# Install powerlevel10k
echo "Installing powerlevel10k..."
git clone \
  --depth=1 https://github.com/romkatv/powerlevel10k.git \
	${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Font installation
mkdir -p ~/.oh-my-zsh/fonts
wget -O ~/.oh-my-zsh/fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -O ~/.oh-my-zsh/fonts/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -O ~/.oh-my-zsh/fonts/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -O ~/.oh-my-zsh/fonts/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Change default shell
