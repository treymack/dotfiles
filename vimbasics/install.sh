#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
VIMRC_SOURCE="$DOTFILES_DIR/vimbasics/.vimrc"
VIMRC_TARGET="$HOME/.vimrc"

# If .vimrc exists and is not a symlink, prompt before removing
if [ -e "$VIMRC_TARGET" ] && [ ! -L "$VIMRC_TARGET" ]; then
    read -p "A .vimrc already exists and is not a symlink. Overwrite it? [y/N]: " answer
    case "$answer" in
        [Yy]*)
            echo "Removing existing $VIMRC_TARGET"
            rm -f "$VIMRC_TARGET"
            ;;
        *)
            echo "Aborting: .vimrc not overwritten."
            exit 1
            ;;
    esac
fi

# Create symlink
ln -sf "$VIMRC_SOURCE" "$VIMRC_TARGET"
echo "Symlinked $VIMRC_TARGET -> $VIMRC_SOURCE"
