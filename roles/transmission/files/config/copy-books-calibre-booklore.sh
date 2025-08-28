#!/bin/bash

# script to upload books after the download, to be able to see automatically in calibre
torrent_path="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

# Normalize booleans to lowercase for reliable comparisons
calibre_enabled_lc=$(printf '%s' "${CALIBRE_ENABLED}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
booklore_enabled_lc=$(printf '%s' "${BOOKLORE_ENABLED}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
extra_enabled_lc=$(printf '%s' "${EXTRA_ENABLED}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')

# Init destinations array
dests=()

# Match if torrent is inside the book downloads folder path (substring match)
if [[ -n "$BOOK_DOWNLOAD_FOLDER" && "$TR_TORRENT_DIR" == *"/$BOOK_DOWNLOAD_FOLDER"* ]]; then
  should_copy=0
  if [[ -n "$CALIBRE_UPLOAD_FOLDER" && "$calibre_enabled_lc" == "true" ]]; then
    dests+=("$CALIBRE_UPLOAD_FOLDER")
    should_copy=1
  fi
  if [[ -n "$BOOKLORE_UPLOAD_FOLDER" && "$booklore_enabled_lc" == "true" ]]; then
    dests+=("$BOOKLORE_UPLOAD_FOLDER")
    should_copy=1
  fi
  if [[ -n "$EXTRA_UPLOAD_FOLDER" && "$extra_enabled_lc" == "true" ]]; then
    dests+=("$EXTRA_UPLOAD_FOLDER")
    should_copy=1
  fi

  if [[ $should_copy -eq 1 ]]; then
    for dest in "${dests[@]}"; do
      echo "Try to copy book: $torrent_path to $dest"
      if [ -f "$torrent_path" ]; then
        echo "It is a file"
        cp -r "$torrent_path" "$dest/"
      fi
      if [ -d "$torrent_path" ]; then
        echo "It is a folder, copy content"
        if [ "$(ls -A \"${torrent_path}\")" ]; then
          cp -r "${torrent_path}"/* "$dest/"
        else
          echo "No files to copy in ${torrent_path}"
        fi
      fi
      # Set sane permissions: dirs 775, files 664
      find "$dest/" -type d -exec chmod 775 {} +
      find "$dest/" -type f -exec chmod 664 {} +
      echo "Done copying to $dest"
    done
  else
    echo "No upload folder set, nothing to do."
  fi
else
  echo "Do nothing, it is not a book"
fi