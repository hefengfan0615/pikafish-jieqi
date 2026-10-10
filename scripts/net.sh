#!/bin/sh

wget_or_curl=$( (command -v wget > /dev/null 2>&1 && echo "wget -qO-") || \
                (command -v curl > /dev/null 2>&1 && echo "curl -skL"))


fetch_network() {
  _filename="abjchess-20261010.nnue"

  if [ -f "$_filename" ]; then
    echo "Exists $_filename, skipping download"
    return
  fi

  if [ -z "$wget_or_curl" ]; then
    >&2 printf "%s\n" "Neither wget or curl is installed." \
          "Install one of these tools to download NNUE files automatically."
    exit 1
  fi

  # The AB-JChess v0.2d release ships the network inside a zip package.
  _zipfile="0.2d_bmi2.zip"
  url="https://github.com/lxsgx23/AB-JChess/releases/download/v0.2d/$_zipfile"
    echo "Downloading from $url ..."
    if $wget_or_curl "$url" > "$_zipfile"; then
      echo "Successfully downloaded $_zipfile"
      if command -v unzip > /dev/null 2>&1; then
        unzip -p "$_zipfile" "*/$_filename" > "$_filename"
      else
        >&2 echo "unzip is required to extract the NNUE from $_zipfile."
        rm -f "$_zipfile"
        return 1
      fi
      rm -f "$_zipfile"
      if [ -s "$_filename" ]; then
        echo "Successfully extracted $_filename"
      else
        echo "Failed to extract $_filename from $url"
        rm -f "$_filename"
        return 1
      fi
    else
      # Download was not successful, return false.
      echo "Failed to download $_zipfile from $url"
      return 1
    fi
}

$call fetch_network
