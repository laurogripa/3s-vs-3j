#!/bin/bash

DB_NAME="codecon"
SOURCE_DIR="./codecon-data"
MONGO_URI="mongodb://localhost:27017"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory '$SOURCE_DIR' not found."
  exit 1
fi

echo "Database: $DB_NAME"
echo "Source Directory: $SOURCE_DIR"

for file in "$SOURCE_DIR"/*.csv; do

  if [ -f "$file" ]; then

    BASENAME=$(basename "$file")
    COLLECTION_NAME="${BASENAME%.*}"

    echo "Importing '$BASENAME' into collection '$COLLECTION_NAME'..."

    mongoimport \
      --uri="$MONGO_URI" \
      --db="$DB_NAME" \
      --collection="$COLLECTION_NAME" \
      --type=csv \
      --headerline \
      --drop \
      --file="$file"

    echo "Import of '$BASENAME' complete."
    echo ""
  fi
done
