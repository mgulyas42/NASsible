#!/bin/bash

# script to upload books after the download, to be able to see automatically in calibre
torrent_path="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

if [[ "$TR_TORRENT_DIR" =~ "$CALIBRE_UPLOADS_FOLDER" ]]; then
  echo "Try to copy book for calibre: $torrent_path to $CALIBRE_UPLOAD_FOLDER"
  if [ -f "$torrent_path" ]; then
    echo "It is a file"
    cp -r "$torrent_path" "$CALIBRE_UPLOAD_FOLDER/"
  fi
  if [ -d "$torrent_path" ]; then
    echo "It is a folder, copy content"
    cp -r "${torrent_path}"/* "$CALIBRE_UPLOAD_FOLDER/"
  fi
  echo "Done"
  # TODO: remove 777 permission
  chmod 777 -R "$CALIBRE_UPLOAD_FOLDER/"
else
  echo "Do nothing, it is not a book"
fi
