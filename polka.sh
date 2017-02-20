#!/bin/bash
# The MIT License (MIT)
# Copyright © 2017 Shreyas Minocha <shreyas@shreyasminocha.me>

# Full license text available at https://shreyas.mit-license.org

POLKA_VERSION = "0.1.0"
POLKA_ARGUMENT = "$1"

relative_path() {
  TRIMMED = eval sed "s/$1/''/g" $2
  return TRIMMED
}

symlink_files() {
  ALL_FILES = find "$POLKA_DIR"
  for file in ALL_FILES do
    CURRENT_FILE = relative_path $POLKA_DIR $file
    grep $CURRENT_FILE .polkaignore

    # if the file is not in .polkaignore
    if [[ $? -ne 0 ]] then

      if [[ -D "$CURRENT_FILE" && !( -D "~/$CURRENT_FILE" ]]; then
          # create directory in "~/" if required
          mkdir "~/$CURRENT_FILE"
      fi

      if [[ -F "$CURRENT_FILE" ]]; then

        # if there exists a file by the same name in "~/"
        if [[ -F "~/$CURRENT_FILE" ]]; then
          if [[ !( -D "~/dotfiles.old" ) ]]; then
            # create an old dotfiles directory if it doesn't exist
            mkdir "~/dotfiles.old"
          fi

          cp --parents "~/$CURRENT_FILE" "~/dotfiles.old"
        fi

      fi
      ln -s "$CURRENT_FILE" "~/"

    fi
  done

  if [[ -D "~/dotfiles.old" ]]; then
    tar -cvf "dotfiles.old.archive" "~/dotfiles.old"
    rm -rf "~/dotfiles.old"
    mv "dotfiles.old.archive" "dotfiles.old"
  fi
}

link() {
  echo "The following symlinks will be made:"

  for file in POLKA_DIR do
    CURRENT_FILE = relative_path $POLKA_DIR $file
    grep $CURRENT_FILE .polkaignore

    # if the file is not in .polkaignore
    if [[ $? -ne 0 ]]; then
      echo "~/$CURRENT_FILE"
    fi
  done

  echo "Are you sure you want to continue?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) symlink_files; break;;
          No ) exit 1;;
      esac
  done
}

version() {
  echo "$POLKA_VERSION"
}

docs() {
  echo "Polka is licensed under the MIT License(See README on github.com/shreyasminocha/polka-dot)\n\n"
  echo "USAGE: polka [COMMAND]\n"
  echo "`polka link`: Links all dotfiles in the current directory to the home folder mimicking the file tree present in the dotfile directory\n"
  echo "`polka version`: Prints out the version of the polka dot script you are using.\n"
  echo "`polka help`: Prints usage and copyright information."
}

case $POLKA_ARGUMENT in
  link ) link; break;;
  help ) docs; break;;
  version ) version; break;;
  * ) docs; break;;
esac
