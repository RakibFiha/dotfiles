#!/usr/bin/env bash

change_random_bg(){
  if [[ "$(uname)" == "Linux" ]]; then
    local all_bg+=($(
          for bg in $HOME/.local/share/backgrounds/*; do 
            echo $bg; 
          done))

    local range=${#all_bg[@]}
    local rand=$(shuf -i 0-${range} -n 1)
    local rand_bg="${all_bg[${rand}]}"

    gsettings set org.gnome.desktop.background picture-uri file://"${rand_bg}"

  elif [[ "$(uname)" == "Darwin" ]]; then
    walls_path="$HOME/Desktop/Wallpaper"
    walls=$(find ${walls_path} -type f -exec sh -c '
    mt=$(file --brief --mime-type "$0")
    [ -z "${mt#image/jpeg}" ] && printf "$0\n"
    ' {} \;);
    wall=$(echo "$walls" | sort --random-sort | head -1)

    osascript <<EOF
tell application "Finder" 
set desktop picture to POSIX file "$wall"
end tell
EOF
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  change_random_bg "$@"
fi
