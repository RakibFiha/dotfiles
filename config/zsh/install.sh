#!/usr/bin/env bash

[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.pre_install

zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
zsh_plugins="$zsh_custom/plugins"

plugin_install_update() {
  local args=("$@")
  for arg in "${args[@]}"; do
    while IFS=, read -r repo repo_dir; do
      repo_dir="${repo_dir// /}"
      echo "Processing plugin repository: $repo" >&2
      echo "Repository plugin directory: $repo_dir" >&2

      if [ -d "$repo_dir/.git" ]; then
        git -C "$repo_dir" pull --depth 1 2> /dev/null || echo "Failed to pull changes."
      else
        git clone --depth 1 -- "$repo" "$repo_dir" || echo "Failed to clone repository."
      fi
    done <<< "$arg"
  done
}

cp .zshrc ~/.zshrc

plugin_install_update "https://github.com/zsh-users/zsh-autosuggestions.git, $zsh_plugins/zsh-autosuggestions"\
                      "https://github.com/zsh-users/zsh-syntax-highlighting.git, $zsh_plugins/zsh-syntax-highlighting"\
                      "https://github.com/zdharma-continuum/fast-syntax-highlighting.git, $zsh_plugins/fast-syntax-highlighting"\
                      "https://github.com/marlonrichert/zsh-autocomplete.git, $zsh_plugins/zsh-autocomplete"
