#!/usr/bin/env bash

[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.pre_install

zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
zsh_plugins="$zsh_custom/plugins"

plugin_install_update() {
  local args=("$@")
  local repo_dirs=()

  for arg in "${args[@]}"; do
    while IFS=, read -r repo repo_dir; do
      repo_dir="${repo_dir// /}"
      repo_dirs+=("$repo_dir")
      echo "Processing plugin repository: $repo" >&2
      echo "Repository plugin directory: $repo_dir" >&2

      if [ -d "$repo_dir/.git" ]; then
        git -C "$repo_dir" pull --depth 1 2> /dev/null || echo "Failed to pull changes."
      else
        git clone --depth 1 -- "$repo" "$repo_dir" || echo "Failed to clone repository."
      fi
    done <<< "$arg"
  done

  pushd "$zsh_plugins" || exit 1
    for removed_repo_dir in *; do
      if ! echo "${repo_dirs[@]}" | grep -wq "$removed_repo_dir" 2>/dev/null; then
        echo "Plugin $removed_repo_dir is removed from config.. Removing.." >&2
        rm -rf "$removed_repo_dir"
      fi
    done
  popd || exit 1
}

cp .zshrc ~/.zshrc

plugin_install_update "https://github.com/zsh-users/zsh-autosuggestions.git, $zsh_plugins/zsh-autosuggestions"\
                      "https://github.com/zdharma-continuum/fast-syntax-highlighting.git, $zsh_plugins/fast-syntax-highlighting"\
                      "https://github.com/marlonrichert/zsh-autocomplete.git, $zsh_plugins/zsh-autocomplete"\
                      "https://github.com/softmoth/zsh-vim-mode.git, $zsh_plugins/zsh-vim-mode"
