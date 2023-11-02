#!/usr/bin/env bash

# if ! [ -x "$(command -v rustup)" ]; then
#      >&2 echo "Error: rustup is not installed!"
#      >&2 echo "Follow this link:"
#      >&2 echo "    https://www.rust-lang.org/tools/install"
#      >&2 echo "for install instructions."
#     exit 1
# fi

if ! rustup component list --installed | grep -qP '^clippy' ; then
     >&2 echo "Error: clippy is not installed!"
     >&2 echo "Use:"
     >&2 echo "    rustup component add clippy"
     >&2 echo "to install it."
    exit 1
fi


if ! rustup component list --installed | grep -qP '^rustfmt' ; then
     >&2 echo "Error: rustfmt is not installed!"
     >&2 echo "Use:"
     >&2 echo "    rustup component add rustfmt"
     >&2 echo "to install it."
    exit 1
fi

if [[ $( cargo check )$? ]]; then
    echo "cargo check is good!"
fi
if [[ $( cargo test )$? ]]; then
    echo "cargo test is good!"
fi
if [[ $( cargo fmt -- --check )$? ]]; then
    echo "cargo fmt is good!"
fi
if [[ $( cargo clippy -- -D warnings )$? ]]; then
    echo "cargo clippy is good!"
fi
