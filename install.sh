#!/bin/bash

install_asdf() {
  rm -rf ~/.asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

  if ! grep -q "asdf-vm" ~/.bashrc; then
    {
      echo -e "\n# asdf-vm"
      echo ". $HOME/.asdf/asdf.sh"
      echo ". $HOME/.asdf/completions/asdf.bash"
    } >> ~/.bashrc
  fi

  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
}

need_install() {
  if which "$1" > /dev/null; then
    echo "Already installed $1"
    return 1
  else
    echo "Installing $1..."
    return 0
  fi
}

check_and_install_requirements() {
  echo "This script needs whiptail, git, asdf and curl to work. So, these will be installed."
  echo "Checking requirements..."
  sudo apt-get update

  if need_install whiptail; then
    sudo apt-get -y install whiptail
  fi
  if need_install git; then
    sudo apt-get -y install git
  fi
  if need_install asdf; then
    install_asdf
  fi
  if need_install curl; then
    sudo apt-get -y install curl
  fi
}

skip() {
  if ! which "$1" > /dev/null; then
    echo "Installing $1..."
    return 1
  fi

  if (whiptail --title "$1" --yesno "$1 is already installed. Do you want to reinstall it?" 8 78); then
    echo "Installing $1..."
    return 1
  else
    echo "Skipping $1..."
    return 0
  fi
}

install_nerd_font() {
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts && curl -fLo "Meslo LG S Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Regular/complete/Meslo%20LG%20S%20Regular%20Nerd%20Font%20Complete.ttf && cd
}

install_zsh() {
  skip zsh && return

  sudo apt-get update && sudo apt-get -y install zsh

  rm -rf ~/.oh-my-zsh ~/.zshrc ~/.fzf ~/.p10k.zsh
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  wget -O ~/.zshrc https://raw.githubusercontent.com/adrimll97/dotfiles/master/zsh/.zshrc
  wget -O ~/.p10k.zsh https://raw.githubusercontent.com/adrimll97/dotfiles/master/zsh/.p10k.zsh
  install_nerd_font

  chsh -s "$(which zsh)"
}

install_tmux() {
  skip tmux && return

  sudo apt-get update && sudo apt-get -y install xclip
  sudo apt-get install tmux
  wget -O ~/.tmux.conf https://raw.githubusercontent.com/adrimll97/dotfiles/master/tmux/.tmux.conf
}

install_nodejs() {
  sudo apt-get update
  # https://github.com/asdf-vm/asdf-nodejs#requirements
  sudo apt-get -y install dirmngr gpg
  asdf plugin-add nodejs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf install nodejs 14.17.0
  asdf global nodejs 14.17.0
}

install_nvim() {
  skip nvim && return

  #Nodejs support
  install_nodejs

  rm -rf ~/.config/nvim
  sudo apt-get -y install silversearcher-ag xclip
  sudo wget -O /usr/local/bin/nvim https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  sudo chmod +x /usr/local/bin/nvim
  mkdir -p ~/.config/nvim/_temp ~/.config/nvim/_backup
  wget -O ~/.config/nvim/init.vim https://raw.githubusercontent.com/adrimll97/dotfiles/master/nvim/init.vim
  wget -O ~/.config/nvim/coc-settings.json https://raw.githubusercontent.com/adrimll97/dotfiles/master/nvim/coc-settings.json
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  nvim +PlugInstall +qa
  nvim -c "CocInstall -sync coc-solargraph|q"
}


check_and_install_requirements

tools=$(
whiptail --title "My UNIX environment" --notags \
  --checklist "Choose what you want to install" 20 78 5 \
  "install_zsh" "zsh       -> Shell" ON \
  "install_tmux" "tmux     -> Terminal multiplexer" ON \
  "install_nvim" "nvim     -> Text editor" ON \
  3>&1 1>&2 2>&3
)

for tool in $tools; do eval "$tool"; done
