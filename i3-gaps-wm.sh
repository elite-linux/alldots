#!/bin/bash

# This is a shell script to install i3/i3-gaps window manager.
# Tested on ubuntu, Mint linux, and kali linux.
# Author: elite-linux
# email: elitelinux0x990@gmail.com
# Youtube: https://www.youtube.com/channel/UCHERlfKz2HOnRMO3dZBGzPw
# (C)opyright: GNU-GPL.
echo -n"

███████ ██      ██ ████████ ███████     ██ ██████         ██████   █████  ██████  ███████       ██     ██ ███    ███ 
██      ██      ██    ██    ██          ██      ██       ██       ██   ██ ██   ██ ██            ██     ██ ████  ████ 
█████   ██      ██    ██    █████ █████ ██  █████  █████ ██   ███ ███████ ██████  ███████ █████ ██  █  ██ ██ ████ ██ 
██      ██      ██    ██    ██          ██      ██       ██    ██ ██   ██ ██           ██       ██ ███ ██ ██  ██  ██ 
███████ ███████ ██    ██    ███████     ██ ██████         ██████  ██   ██ ██      ███████        ███ ███  ██      ██ 

		elite-linux -- https://www.youtube.com/channel/UCHERlfKz2HOnRMO3dZBGzPw"
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root"
   exit 1
fi
echo -n 'Please inter the username: '
read -r USERNAME
UNAME=/home/$USERNAME
CONFIG_DIR=$UNAME/.config/

I3CONIG=$CONFIG_DIR/i3/
NVIM_CONFIG=$CONFIG_DIR/nvim

mkdir -p "$CONFIG_DIR"/nvim


# Installing required pacakges.

add-apt-repository ppa:kgilmer/speed-ricer
apt update

apt install feh ripgrep ranger fzf rofi  neovim i3 i3lock i3blocks i3-wm compton i3status i3-gaps i3-gaps-session i3-gaps-wm curl git zsh nodejs

# Plug for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Installing oh-my-zsh...

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/elite-linux/alldots
cd alldots || exit
cp init.vim "$NVIM_CONFIG"
cp config "$I3CONIG"
cp compton.conf "$CONFIG_DIR"
