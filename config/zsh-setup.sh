# Download zsh
cd $HOME
wget -O ~/zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download

# Unpack zsh
mkdir zsh && tar -xvf zsh.tar.gz -C zsh --strip-components 1

# Install zsh
cd zsh
./configure --prefix=$HOME
make
make install

# Install oh-my-zsh
cd $HOME
wget ~/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
bash install.sh

# Install powerlevel10k plugin
git clone \
  --depth=1 https://github.com/romkatv/powerlevel10k.git \
	${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
