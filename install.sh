#!/usr/bin/env bash

set -euo pipefail

install_neovim() {
  if [[ "$(uname)" == "Linux" ]]; then
    local arch="linux$(uname -i | cut -d '_' -f2)"
  elif [[ "$(uname)" == "Darwin" ]]; then
    local arch="macos"
  else
    echo "uname: $(uname) not supported" &>2
    exit 1
  fi
  local version="v0.9.5"
  local url="https://github.com/neovim/neovim/releases/download/${version}/nvim-${arch}.tar.gz"
  local tar_file="nvim-${arch}.tar.gz"
  local tarred="nvim-${arch}"
  local install_path="$HOME/.local/bin/"
  local install_dir="$HOME/.local/bin/${tarred}"

  mkdir -p .done
  pushd .done
    curl -OL $url
    [[ "$arch" == "macos" ]] && xattr -c ./${tar_file} ;
    tar xzvf "${tar_file}"
    [ -d "$install_dir" ] && rm -r "${install_dir}" ;
    mv  "${tarred}" "${install_path}"
  popd

  rm -r .done
}

install_lunarvim() {
  local version="release-1.3/neovim-0.9"
  LV_BRANCH="${version}" bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
}

install_neovim
install_lunarvim

pushd config
 for file in *; do
   cp -r $file $HOME/.config/
 done
popd

pushd $HOME/.config/zsh
  bash install.sh
popd

pushd $HOME/.config/tmux
  bash install.sh
popd
