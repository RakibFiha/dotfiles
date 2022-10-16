#!/usr/bin/env bash

set -euo pipefail

pushd config
 for file in *; do
   cp -r $file $HOME/.config/
 done
popd
