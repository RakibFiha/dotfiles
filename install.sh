#!/usr/bin/env bash

set -euo pipefail

install_neovim() {
  local arch
  if [[ "$(uname)" == "Linux" ]]; then
    arch="linux$(uname -i | cut -d '_' -f2)"
  elif [[ "$(uname)" == "Darwin" ]]; then
    arch="macos"
  else
    echo "uname: $(uname) not supported" >&2
    exit 1
  fi
  local version="v0.9.5"
  local url="https://github.com/neovim/neovim/releases/download/$version/nvim-$arch.tar.gz"
  local tar_file="nvim-$arch.tar.gz"
  local tarred="nvim-$arch"
  local install_path="$HOME/.local/bin/"
  local install_dir="$HOME/.local/bin/$tarred"

  mkdir -p .done
  pushd .done
    curl -OL "$url"
    [[ "$arch" == "macos" ]] && xattr -c "$tar_file" ;
    tar xzvf "$tar_file"
    [ -d "$install_dir" ] && rm -r "$install_dir" ;
    mv  "$tarred" "$install_path"
  popd

  pip3 install -r requirements.txt

  rm -r .done
}

install_lunarvim() {
  local version="release-1.3/neovim-0.9"
  LV_BRANCH="${version}" bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
}

config() {
  pushd config
    for file in *; do
      ln -nsf "$PWD/$file" "$HOME/.config/$file"
    done
    find "$HOME/.config/" -maxdepth 1 -type l ! -exec test -e {} \; -exec unlink {} \;
  popd

  pushd bin
    mkdir -p "$HOME/.local/bin"
    for file in *; do
      ln -nsf "$PWD/$file" "$HOME/.local/bin/$file"
    done
    find "$HOME/.local/bin" -maxdepth 1 -type l ! -exec test -e {} \; -exec unlink {} \;
  popd
  
  pushd "$HOME/.config/zsh"
    bash install.sh
  popd
  
  pushd "$HOME/.config/tmux"
    bash install.sh
  popd

  local walls_path="${MY_BACKGROUND_DIR:-$HOME/.local/share/backgrounds/}"
  mkdir -p "$walls_path"
  local walls_zip_name="bg.zip"

  pushd "$walls_path"
    if [[ -e "$walls_zip_name" ]]; then
       while true; do
           read -rp "$walls_zip_name already exists. Replace? (y/N): " answer
           answer=${answer:-N}
           case "$answer" in
               [Yy]*) echo "Yes, continuing to replace..." && break ;;
               [Nn]*) echo "No, not replacing..." && break ;;
               *) echo "Invalid input. Please enter 'y' or 'n'." ;;
           esac
       done
    fi
    if [[ ! -e "$walls_zip_name" ]] || [[ "$answer" =~ ^[Yy]$ ]]; then
      python3 - <<RUNAS
import gdown
id = "1HGrBguQaxfIJ76jwYINoxseTGBnt12td"
output = "$walls_zip_name"
gdown.download(id=id, output=output)
RUNAS
    fi
    echo "Unzipping $walls_zip_name:" && unzip "$walls_zip_name"
  popd
}

install() {
  install_neovim
  install_lunarvim
}

[[ "$#" -ne "1" ]] && echo "Usage: $0 config|install|all" && exit 1;

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  case $1 in
    config) config ;;
    install) install ;;
    all) install && config ;;
    *) echo "no such option $1" && exit 1 ;;
  esac
fi
