#!/bin/bash

# Store original shell
SHELL_ORIG=$SHELL;

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

# ------------------------
# Install z shell (zsh)

# Check if ZSH was already downloaded
if [[ ! -e $HOME/zsh/ ]]; then
	# Download zsh
	echo "Downloading zsh..."
	cd $HOME
	wget -O ~/zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download

	# Unpack zsh
	echo "Unpacking zsh..."
	mkdir zsh && tar -xvf zsh.tar.gz -C zsh --strip-components 1
	# Remove the tar archive
	rm -f zsh.tar.gz

	# Install zsh
	echo "Installing zsh..."
	cd zsh
	./configure --prefix=$HOME
	make
	make install
fi;


# ------------------------
# Install oh-my-zsh

if [[ ! -e $HOME/.oh-my-zsh/ ]]; then
	# Download oh-my-zsh
	echo "Downloading oh-my-zsh..."
	cd $HOME
	wget ~/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

	# Install oh-my-zsh
	echo "Installing oh-my-zsh..."
	bash ~/install.sh

fi;

# ------------------------
# Install powerlevel10k

if [[ ! -e $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]]; then

	echo "Installing powerlevel10k..."
	git clone \
		--depth=1 https://github.com/romkatv/powerlevel10k.git \
		${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

fi;


# ------------------------
# Install NERD Fonts

if [[ ! -e "/home/ktmeaton/.oh-my-zsh/fonts/MesloLGS NF Regular.ttf" ]]; then

	mkdir -p ~/.oh-my-zsh/fonts
	cp -r fonts/* ~/.oh-my-zsh/fonts/

	#wget -O ~/.oh-my-zsh/fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
	#wget -O ~/.oh-my-zsh/fonts/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
	#wget -O ~/.oh-my-zsh/fonts/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
	#wget -O ~/.oh-my-zsh/fonts/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

fi;

# Configure
comment="\n# Set Z shell (zsh) as default\n"

# Change default shell
if [[ $SHELL_ORIG == *bash* ]]; then
  rc=$HOME/.bashrc
	cmd="if [[ \$- == *'i'* ]]; then\n  export SHELL=\$HOME/bin/zsh;\n exec \$SHELL;\nfi";
elif [[ $SHELL_ORIG == *tcsh* ]]; then
	rc=$HOME/.tcshrc
	cmd="if ( \$?prompt == 1 ) then\nsetenv SHELL \$HOME/bin/zsh\nexec \$SHELL\nendif";
elif [[ $SHELL_ORIG == *zsh* ]]; then
	rc=$HOME/.zshrc
	cmd="";
else
	echo "Unrecognized shell $SHELL, cannot set zsh as default."
	exit 1;
fi

# Check if rc file has already been configured for zsh
if [[ ! `grep "zsh" $rc` ]]; then
	echo "Configuring $rc to zsh as default.";
  echo -e ${comment}${cmd} >> $rc;
	echo "Open a new terminal to begin z shell setup."
fi


# Extra

echo "Fonts not appearing correctly?"
echo "Read: https://github.com/romkatv/powerlevel10k/blob/master/README.md#manual-font-installation"
