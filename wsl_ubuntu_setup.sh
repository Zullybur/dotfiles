# Update system and install zsh
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install zsh

# Force zsh to launch if running bash
cat << EOF >> ~/.bashrc
if [ -t 1 ]; then
    exec zsh
fi
EOF

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install dotfiles
pushd ~ > /dev/null
mkdir src
pushd src > /dev/null
git clone git@github.com:Zullybur/dotfiles.git
pushd dotfiles > /dev/null
ln -sf ~/src/dotfiles/.zshrc ~/.zshrc
ln -sf ~/src/dotfiles/.vimrc ~/.vimrc
ln -sf ~/src/dotfiles/.aliases ~/.aliases
ln -sf ~/src/MISC/dotfiles/.private ~/.private
ln -sf ~/src/MISC/dotfiles/.gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
popd > /dev/null # ~/src
popd > /dev/null # ~

# Install darcula theme for vim
git clone git@github.com:blueshirts/darcula.git
mkdir -p ~/.vim/colors
cp darcula/colors/darcula.vim ~/.vim/colors/

# Set up plugins for Vim
mkdir -p ~/.vim/pack/plugins
mkdir -p ~/.vim/pack/plugins/start
mkdir -p ~/.vim/pack/plugins/opt
# Terraform
git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugins/start/vim-terraform

# Install powerline fonts
pushd src > /dev/null
git clone https://github.com/powerline/fonts.git
pushd fonts > /dev/null
./install.sh
popd > /dev/null # ~/src
rm -rf fonts
popd > /dev/null # ~
