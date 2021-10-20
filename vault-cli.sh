#!/bin/sh

if [ "$#" -gt 1 ]; then
  for FILE in "${@:2}"; do
    ansible-vault $1 $FILE
  done
else
  find ./ -name "vault*.yml" -exec ansible-vault $1 {} \;
fi